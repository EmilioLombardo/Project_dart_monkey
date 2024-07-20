import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;

class AdminGroupAdmissionPage extends StatefulWidget {
  @override
  _AdminGroupAdmissionPageState createState() => _AdminGroupAdmissionPageState();
}

class _AdminGroupAdmissionPageState extends State<AdminGroupAdmissionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordFieldController = TextEditingController();
  final List<String> selectedCommittees = [];
  bool status = false;
  String? documentId;
  bool passwordExists = false;

  @override
  void initState() {
    super.initState();
    _fetchLatestGroupAdmission();
  }

  Future<void> _fetchLatestGroupAdmission() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('groupAdmissions')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      var data = doc.data() as Map<String, dynamic>;
      setState(() {
        documentId = doc.id;
        status = data['status'] ?? false;
        _startDateController.text = (data['openedAt'] as Timestamp).toDate().toString().split(' ')[0];
        _endDateController.text = (data['closedAt'] as Timestamp).toDate().toString().split(' ')[0];
        selectedCommittees.addAll(List<String>.from(data['committees'] ?? []));
        passwordExists = data['password'] != null && data['password'].isNotEmpty;
      });
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _toggleCommitteeSelection(String committeeName) {
    setState(() {
      if (selectedCommittees.contains(committeeName)) {
        selectedCommittees.remove(committeeName);
      } else {
        selectedCommittees.add(committeeName);
      }
    });
  }

  Future<void> _saveGroupAdmission() async {
    if (_formKey.currentState!.validate()) {
      final startDate = DateTime.parse(_startDateController.text);
      final endDate = DateTime.parse(_endDateController.text);

      final groupAdmissionData = {
        'createdAt': FieldValue.serverTimestamp(),
        'status': status,
        'openedAt': startDate,
        'closedAt': endDate,
        'committees': selectedCommittees,
        'password': _passwordFieldController.text.isNotEmpty ? _passwordFieldController.text : null,
      };

      if (documentId == null) {
        final newDoc = FirebaseFirestore.instance.collection('groupAdmissions').doc();
        groupAdmissionData['uid'] = newDoc.id;
        await newDoc.set(groupAdmissionData);
      } else {
        await FirebaseFirestore.instance.collection('groupAdmissions').doc(documentId!).update(groupAdmissionData);
      }

      setState(() {});
    }
  }

  Future<void> _activateCommittees() async {
    if (documentId != null) {
      var docRef = FirebaseFirestore.instance.collection('groupAdmissions').doc(documentId);
      var docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        var data = docSnapshot.data() as Map<String, dynamic>;

        for (String committee in selectedCommittees) {
          if (!data.containsKey(committee)) {
            await docRef.update({
              committee: FieldValue.arrayUnion([]),
            });
          }
        }
      }
    }
  }

  void _toggleStatus() async {
    setState(() {
      status = !status;
    });
    await _saveGroupAdmission();
    await _activateCommittees();
  }

  void _showStartNewRoundDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Start ny opptaksrunde'),
          content: Text(
            'Er du sikker på at du vil starte en ny opptaksrunde? Ved å gjøre det vil resultater fra denne opptaksrunden bli tapt. Ønsker du å deaktivere runden kan du gjøre det ved å klikke på deaktiver-knappen.',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                if (documentId != null) {
                  await FirebaseFirestore.instance.collection('groupAdmissions').doc(documentId!).delete();
                }
                setState(() {
                  documentId = null;
                  status = false;
                  _startDateController.clear();
                  _endDateController.clear();
                  selectedCommittees.clear();
                  passwordExists = false;
                });
              },
              child: Text('Start ny runde'),
            ),
          ],
        );
      },
    );
  }

  void _showViewResultsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hent resultater'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Skriv inn riktig passord for å kunne eksportere resultatene fra denne runden.'),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Passord'),
                obscureText: true,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Del dette passordet kun med undergruppeledere!',
                  style: TextStyle(color: Colors.blue[900], fontSize: 12),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (documentId != null) {
                  DocumentSnapshot doc = await FirebaseFirestore.instance.collection('groupAdmissions').doc(documentId).get();
                  if (doc.exists && doc['password'] == _passwordController.text) {
                    // Start download of empty CSV file
                    final csvData = ''; // Empty CSV content
                    final blob = html.Blob([csvData], 'text/csv', 'native');
                    final url = html.Url.createObjectUrlFromBlob(blob);
                    final anchor = html.AnchorElement(href: url)
                      ..setAttribute('download', 'results.csv')
                      ..click();
                    html.Url.revokeObjectUrl(url);

                    Navigator.of(context).pop();
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Feil passord')),
                    );
                  }
                }
              },
              child: Text('Fortsett'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undergruppeopptak'),
        backgroundColor: Color(0xFF1045A6),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildStatusIndicator(),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildDateField(_startDateController, 'Startdato')),
                        SizedBox(width: 10),
                        Expanded(child: _buildDateField(_endDateController, 'Sluttdato')),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Velg komiteer:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildCommitteesList(),
                    SizedBox(height: 20),
                    if (!passwordExists)
                      TextField(
                        controller: _passwordFieldController,
                        decoration: InputDecoration(
                          labelText: 'Sett passord',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        obscureText: true,
                      ),
                    if (!passwordExists) SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _toggleStatus,
                        child: Text(status ? 'Deaktiver' : 'Aktiver'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1045A6),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                      ),
                    ),
                    if (status) ...[
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _showStartNewRoundDialog,
                            child: Text('Start ny opptaksrunde'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1045A6),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _showViewResultsDialog,
                            child: Text('Hent resultater'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1045A6),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: status ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          status ? 'Aktiv' : 'Inaktiv',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: status ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildCommitteesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('komiteer').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var committees = snapshot.data!.docs;
        List<Widget> committeeWidgets = [];
        for (int i = 0; i < committees.length; i += 5) {
          List<Widget> rowWidgets = [];
          for (int j = i; j < i + 5 && j < committees.length; j++) {
            var committeeName = committees[j]['name'];
            var isSelected = selectedCommittees.contains(committeeName);
            rowWidgets.add(
              Expanded(
                child: GestureDetector(
                  onTap: () => _toggleCommitteeSelection(committeeName),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blueAccent : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Text(
                      committeeName,
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
          committeeWidgets.add(Row(children: rowWidgets));
        }
        return Column(children: committeeWidgets);
      },
    );
  }

  Widget _buildDateField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _selectDate(controller),
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vennligst velg $labelText';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
