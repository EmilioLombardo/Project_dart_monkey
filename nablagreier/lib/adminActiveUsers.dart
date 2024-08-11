import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminActiveUsersPage extends StatefulWidget {
  @override
  _AdminActiveUsersPageState createState() => _AdminActiveUsersPageState();
}

class _AdminActiveUsersPageState extends State<AdminActiveUsersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSidePanelOpen = false;
  String sortBy = 'ascending';
  DateTime? startDate;
  DateTime? endDate;
  bool isFilterApplied = false;
  Query? _activeUsersQuery;

  List<String> defaultFields = ['username', 'email', 'name', 'lastName', 'createdAt'];
  List<String> extraFields = [
    'adminAccess',
    'badges',
    'biography',
    'birthDate',
    'cardNumber',
    'civilStatus',
    'class',
    'favoriteQuotes',
    'hobbies',
    'lastLogin',
    'memberOf',
    'origin',
    'profilePicture',
    'socialLinks',
    'superUser',
    'theme',
    'uid'
  ];
  List<String> allFields = [];
  Map<String, bool> fieldVisibility = {};

  @override
  void initState() {
    super.initState();
    // Initialize field visibility
    for (var field in defaultFields) {
      fieldVisibility[field] = true;
    }
    for (var field in extraFields) {
      fieldVisibility[field] = false;
    }
    _activeUsersQuery = _buildQuery();
  }

  void _toggleField(String field) {
    setState(() {
      fieldVisibility[field] = !(fieldVisibility[field] ?? false);
    });
  }

  void _toggleSidePanel() {
    setState(() {
      isSidePanelOpen = !isSidePanelOpen;
    });
  }

  void _selectDate(BuildContext context, bool isStart) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

  Query _buildQuery() {
    Query query = FirebaseFirestore.instance.collection('activeUsers');
    if (isFilterApplied) {
      if (startDate != null && endDate != null) {
        query = query
            .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate!))
            .where('createdAt', isLessThanOrEqualTo: Timestamp.fromDate(endDate!));
      }
      if (sortBy == 'ascending') {
        query = query.orderBy('createdAt', descending: false);
      } else if (sortBy == 'descending') {
        query = query.orderBy('createdAt', descending: true);
      }
    }
    return query;
  }

  void _applyFilters() {
    setState(() {
      isFilterApplied = true;
      _activeUsersQuery = _buildQuery();
      _toggleSidePanel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Aktive Brukere'),
        backgroundColor: Color(0xFF1045A6),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleSidePanel,
        ),
      ),
      body: Stack(
        children: [
          _buildMainContent(),
          if (isSidePanelOpen) _buildSidePanel(context),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return StreamBuilder<QuerySnapshot>(
      stream: _activeUsersQuery!.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final users = snapshot.data!.docs;

        if (users.isEmpty) {
          return Center(child: Text('No active users found.'));
        }

        // Get all fields from the first document
        final firstUser = users.first.data() as Map<String, dynamic>;
        allFields = firstUser.keys.toList();
        // Ensure fieldVisibility contains all fields
        for (var field in allFields) {
          fieldVisibility[field] ??= defaultFields.contains(field);
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: allFields.where((field) => fieldVisibility[field]!).map((key) {
                return DataColumn(
                  label: Text(
                    key,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
              rows: users.map((userDoc) {
                final user = userDoc.data() as Map<String, dynamic>;
                return DataRow(
                  cells: allFields.where((field) => fieldVisibility[field]!).map((field) {
                    var value = user[field];
                    if (field == 'createdAt' && value is Timestamp) {
                      value = DateFormat('dd-MM-yyyy').format(value.toDate());
                    }
                    return DataCell(Text(value.toString()));
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSidePanel(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: 0,
      bottom: 0,
      left: isSidePanelOpen ? 0 : -MediaQuery.of(context).size.width * 0.5,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5, // Take up half the screen width
        height: MediaQuery.of(context).size.height, // Take up the full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xFF1045A6),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Panel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: _toggleSidePanel,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  ExpansionTile(
                    title: Text(
                      'Brukerfelt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: _buildFieldSelection(),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Sorter etter CreatedAt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      ListTile(
                    title: DropdownButton<String>(
                      value: sortBy,
                      items: [
                        DropdownMenuItem(
                          child: Text('Ascending'),
                          value: 'ascending',
                        ),
                        DropdownMenuItem(
                          child: Text('Descending'),
                          value: 'descending',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          sortBy = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _selectDate(context, true),
                            child: Text(
                              startDate != null ? DateFormat('dd-MM-yyyy').format(startDate!) : 'Start Date',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _selectDate(context, false),
                            child: Text(
                              endDate != null ? DateFormat('dd-MM-yyyy').format(endDate!) : 'End Date',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _applyFilters,
                    child: Text('Apply Filters'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1045A6),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFieldSelection() {
    List<Widget> fieldWidgets = [];
    List<String> combinedFields = defaultFields + extraFields;

    for (int i = 0; i < combinedFields.length; i += 4) {
      List<Widget> rowWidgets = [];
      for (int j = i; j < i + 4 && j < combinedFields.length; j++) {
        String field = combinedFields[j];
        bool isSelected = fieldVisibility[field] ?? false;
        rowWidgets.add(
          Expanded(
            child: GestureDetector(
              onTap: () => _toggleField(field),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blueAccent : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Text(
                  field,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      }
      fieldWidgets.add(Row(children: rowWidgets));
    }

    return fieldWidgets;
  }
}
