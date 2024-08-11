import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminEditAdminGroupPage extends StatefulWidget {
  @override
  _AdminEditAdminGroupPageState createState() => _AdminEditAdminGroupPageState();
}

class _AdminEditAdminGroupPageState extends State<AdminEditAdminGroupPage> {
  void _navigateToGroupDetails(DocumentSnapshot group, String collectionName) {
    if (collectionName == 'adminGroups') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroupDetailsPage(group: group, collectionName: collectionName),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RightsSelectionPage(group: group, collectionName: collectionName),
        ),
      );
    }
  }

  Widget _buildGroupSelection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Komiteer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildGroupSection('komiteer'),
          SizedBox(height: 20),
          Text('Kull', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildGroupSection('Kull'),
          SizedBox(height: 20),
          Text('Egendefinerte grupper', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildGroupSection('adminGroups'),
        ],
      ),
    );
  }

  Widget _buildGroupSection(String collectionName) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection(collectionName).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No groups found'));
        }

        final groups = snapshot.data!.docs;
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 3 / 4,
          ),
          itemCount: groups.length,
          itemBuilder: (context, index) {
            final group = groups[index];
            final groupName = group['name'];

            return GestureDetector(
              onTap: () => _navigateToGroupDetails(group, collectionName),
              child: _buildGroupCard(groupName),
            );
          },
        );
      },
    );
  }

  Widget _buildGroupCard(String groupName) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          groupName,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adminstrer tilganger'),
        backgroundColor: Color(0xFF1045A6),
      ),
      body: _buildGroupSelection(),
    );
  }
}

class GroupDetailsPage extends StatefulWidget {
  final DocumentSnapshot group;
  final String collectionName;

  GroupDetailsPage({required this.group, required this.collectionName});

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  List<String> _selectedRights = [];
  List<String> _members = [];
  String? _groupName;
  final _memberSearchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _selectedRights = List<String>.from(widget.group['rights'] ?? []);
    _members = List<String>.from(widget.group['members'] ?? []);
    _groupName = widget.group['name'];
  }

  Future<void> _updateGroup() async {
    final batch = FirebaseFirestore.instance.batch();

    // Update the group's rights and members
    final groupDoc = FirebaseFirestore.instance.collection(widget.collectionName).doc(widget.group.id);
    batch.update(groupDoc, {
      'rights': _selectedRights,
      'members': _members,
    });

    // Update the adminAccess field for each member in the group
    for (String memberId in _members) {
      final userDoc = FirebaseFirestore.instance.collection('activeUsers').doc(memberId);
      batch.update(userDoc, {
        'adminAccess': _selectedRights,
      });
    }

    // Commit the batch write
    await batch.commit();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Group and user admin access updated successfully!')),
    );
    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit $_groupName'),
        backgroundColor: Color(0xFF1045A6),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _memberSearchController,
                decoration: InputDecoration(labelText: 'Search Members'),
                onChanged: (value) {
                  _searchMembers(value);
                },
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
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
                    SizedBox(height: 20),
                    Text('Assign Rights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    FutureBuilder<QuerySnapshot>(
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateGroup,
                child: Text('Update Group'),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1045A6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RightsSelectionPage extends StatefulWidget {
  final DocumentSnapshot group;
  final String collectionName;

  RightsSelectionPage({required this.group, required this.collectionName});

  @override
  _RightsSelectionPageState createState() => _RightsSelectionPageState();
}

class _RightsSelectionPageState extends State<RightsSelectionPage> {
  List<String> _selectedRights = [];
  String? _groupName;

  @override
  void initState() {
    super.initState();
    _selectedRights = List<String>.from(widget.group['rights'] ?? []);
    _groupName = widget.group['name'];
  }

  Future<void> _updateRights() async {
    await FirebaseFirestore.instance.collection(widget.collectionName).doc(widget.group.id).update({
      'rights': _selectedRights,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rights updated successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit $_groupName'),
        backgroundColor: Color(0xFF1045A6),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<QuerySnapshot>(
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
          ),
        ),
      ),
    );
  }
}
