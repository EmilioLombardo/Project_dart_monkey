import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AdminAddAdminGroupPage extends StatefulWidget {
  @override
  _AdminAddAdminGroupPageState createState() => _AdminAddAdminGroupPageState();
}

class _AdminAddAdminGroupPageState extends State<AdminAddAdminGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final String _uid = Uuid().v4(); // Generate a unique UID
  final _memberSearchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  List<String> _members = [];
  List<String> _selectedRights = [];

  Future<void> _addAdminGroup() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('adminGroups').doc(_uid).set({
        'uid': _uid,
        'name': _nameController.text,
        'description': _descriptionController.text,
        'createdAt': Timestamp.now(),
        'members': _members,
        'rights': _selectedRights,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Admin Group added successfully!')),
      );

      Navigator.pop(context);
    }
  }

  Future<void> _searchMembers(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('activeUsers')
        .where('name', isGreaterThanOrEqualTo: query)
        .get();

    setState(() {
      _searchResults = result.docs;
    });
  }

  Future<void> _addMemberToGroup(String memberId) async {
    if (_members.contains(memberId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Member is already in the group!')),
      );
      return;
    }

    setState(() {
      _members.add(memberId);
    });
  }

  Future<void> _removeMemberFromGroup(String memberId) async {
    setState(() {
      _members.remove(memberId);
    });
  }

  Widget _buildMembersSection() {
    return Column(
      children: [
        TextField(
          controller: _memberSearchController,
          decoration: InputDecoration(labelText: 'Search Members'),
          onChanged: (value) {
            _searchMembers(value);
          },
        ),
        SizedBox(height: 10),
        ListView(
          shrinkWrap: true,
          children: [
            Text('Add Members', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ..._searchResults.map((user) {
              final userData = user.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(userData['name'] ?? 'No Name'),
                subtitle: Text(userData['email'] ?? 'No Email'),
                onTap: () => _addMemberToGroup(user.id),
              );
            }).toList(),
            SizedBox(height: 20),
            Text('Current Members', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ..._members.map((memberId) {
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('activeUsers').doc(memberId).get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final user = snapshot.data!.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(user['name'] ?? 'No Name'),
                    subtitle: Text(user['email'] ?? 'No Email'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () => _removeMemberFromGroup(memberId),
                    ),
                  );
                },
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  Widget _buildRightsSection() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('adminRights').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No rights found'));
        }

        final rights = snapshot.data!.docs;
        final rightsByCategory = <String, List<DocumentSnapshot>>{};

        for (var right in rights) {
          final category = right['category'] as String;
          if (rightsByCategory[category] == null) {
            rightsByCategory[category] = [];
          }
          rightsByCategory[category]!.add(right);
        }

        return ListView(
          shrinkWrap: true,
          children: rightsByCategory.entries.map((entry) {
            final category = entry.key;
            final categoryRights = entry.value;

            return ExpansionTile(
              title: Text(
                category,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: categoryRights.map((right) {
                final rightId = right.id;
                final rightName = right['name'];
                final rightDescription = right['description'];
                final isSelected = _selectedRights.contains(rightId);

                return CheckboxListTile(
                  title: Text(rightName),
                  subtitle: Text(rightDescription),
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedRights.add(rightId);
                      } else {
                        _selectedRights.remove(rightId);
                      }
                    });
                  },
                );
              }).toList(),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legg til ny Admin Gruppe'),
        backgroundColor: Color(0xFF1045A6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              _buildMembersSection(),
              SizedBox(height: 20),
              _buildRightsSection(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addAdminGroup,
                child: Text('Add Admin Group'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1045A6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
