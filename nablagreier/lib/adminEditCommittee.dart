import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminEditCommitteePage extends StatefulWidget {
  @override
  _AdminEditCommitteePageState createState() => _AdminEditCommitteePageState();
}

class _AdminEditCommitteePageState extends State<AdminEditCommitteePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _emailController = TextEditingController();
  final _logoController = TextEditingController();

  String? _selectedCommitteeId;
  TextEditingController _searchController = TextEditingController();

  Map<String, dynamic> _activeMembers = {};
  Map<String, dynamic> _inactiveMembers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rediger Komité'),
        backgroundColor: Color(0xFF1045A6),
      ),
      body: _selectedCommitteeId == null
          ? _buildCommitteeSelection()
          : _buildEditForm(),
    );
  }

  Widget _buildCommitteeSelection() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('komiteer').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No committees found'));
        }

        final committees = snapshot.data!.docs;

        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 3 / 4,
          ),
          itemCount: committees.length,
          itemBuilder: (context, index) {
            final committee = committees[index];
            final committeeName = committee['name'];
            final committeeLogo = committee['logo'] ?? 'assets/default_logo.png';

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCommitteeId = committee.id;
                  _nameController.text = committee['name'] ?? '';
                  _aboutController.text = committee['about'] ?? '';
                  _emailController.text = committee['email'] ?? '';
                  _logoController.text = committee['logo'] ?? '';
                  _activeMembers = Map<String, dynamic>.from(committee['activeMembers'] ?? {});
                  _inactiveMembers = Map<String, dynamic>.from(committee['unactiveMembers'] ?? {});
                });
              },
              child: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(committeeLogo),
                      radius: 30,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      committeeName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEditForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _aboutController,
              decoration: InputDecoration(
                labelText: 'About',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _logoController,
              decoration: InputDecoration(
                labelText: 'Logo URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Users',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            _buildSearchBar(),
            _buildMemberList(),
            SizedBox(height: 16.0),
            Text(
              'Active Members',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            _buildSelectedMembersList(_activeMembers, true),
            SizedBox(height: 16.0),
            Text(
              'Inactive Members',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            _buildSelectedMembersList(_inactiveMembers, false),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _editCommittee,
              child: Text('Update Committee'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1045A6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          labelText: 'Search by name, last name, or username',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildMemberList() {
    if (_searchController.text.isEmpty) {
      return Container();
    }

    final searchQuery = _searchController.text.toLowerCase();

    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('activeUsers').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No members found'));
        }

        final members = snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return data['name']?.toLowerCase().contains(searchQuery) == true ||
              data['lastName']?.toLowerCase().contains(searchQuery) == true ||
              data['username']?.toLowerCase().contains(searchQuery) == true;
        }).toList();

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index].data() as Map<String, dynamic>;
            final memberId = members[index].id;
            final isActive = _activeMembers.containsKey(member['username']);
            return ListTile(
              title: Text(member['name'] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${member['username'] ?? ''}'),
                  if (isActive) ...[
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(labelText: 'Roles'),
                            onChanged: (value) {
                              member['roles'] = value.split(',').map((role) => role.trim()).toList();
                            },
                            onSubmitted: (value) {
                              _saveRole(memberId, member['roles']);
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.save),
                          onPressed: () {
                            _saveRole(memberId, member['roles']);
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              trailing: Switch(
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      member['joined'] = Timestamp.now(); // Set joined date to now
                      _inactiveMembers.remove(member['username']);
                      _activeMembers[member['username']] = member;
                      _addCommitteeToUser(member['username'], _nameController.text);
                    } else {
                      member['left'] = Timestamp.now(); // Set left date to now
                      _activeMembers.remove(member['username']);
                      _inactiveMembers[member['username']] = member;
                      _removeCommitteeFromUser(member['username'], _nameController.text);
                    }
                    _updateMemberStatus(member['username'], member, value);
                  });
                },
              ),
            );
          },
        );
      },
    );
  }

  void _saveRole(String username, List<dynamic> roles) {
    setState(() {
      if (_activeMembers.containsKey(username)) {
        _activeMembers[username]['roles'] = roles;
      } else if (_inactiveMembers.containsKey(username)) {
        _inactiveMembers[username]['roles'] = roles;
      }
      _updateMemberRoles(username, roles);
    });
  }

  Future<void> _updateMemberRoles(String username, List<dynamic> roles) async {
    final docRef = FirebaseFirestore.instance.collection('komiteer').doc(_selectedCommitteeId);
    final activePath = 'activeMembers.$username.roles';
    final inactivePath = 'unactiveMembers.$username.roles';

    if (_activeMembers.containsKey(username)) {
      await docRef.update({activePath: roles});
    } else if (_inactiveMembers.containsKey(username)) {
      await docRef.update({inactivePath: roles});
    }
  }

  Widget _buildSelectedMembersList(Map<String, dynamic> members, bool isActiveList) {
    if (members.isEmpty) {
      return Container();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final memberKey = members.keys.elementAt(index);
        final member = members[memberKey];
        return ListTile(
          title: Text(member['name'] ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username: $memberKey'),
              if (isActiveList) ...[
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Roles'),
                        onChanged: (value) {
                          member['roles'] = value.split(',').map((role) => role.trim()).toList();
                        },
                        onSubmitted: (value) {
                          _saveRole(memberKey, member['roles']);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        _saveRole(memberKey, member['roles']);
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
          trailing: Switch(
            value: isActiveList,
            onChanged: (value) {
              setState(() {
                if (value) {
                  member['joined'] = Timestamp.now(); // Set joined date to now
                  _inactiveMembers.remove(memberKey);
                  _activeMembers[memberKey] = member;
                  _addCommitteeToUser(memberKey, _nameController.text);
                } else {
                  member['left'] = Timestamp.now(); // Set left date to now
                  _activeMembers.remove(memberKey);
                  _inactiveMembers[memberKey] = member;
                  _removeCommitteeFromUser(memberKey, _nameController.text);
                }
                _updateMemberStatus(memberKey, member, value);
              });
            },
          ),
        );
      },
    );
  }

  Future<void> _addCommitteeToUser(String username, String committeeName) async {
    final userQuerySnapshot = await FirebaseFirestore.instance.collection('activeUsers').where('username', isEqualTo: username).get();
    if (userQuerySnapshot.docs.isNotEmpty) {
      final userDocRef = userQuerySnapshot.docs.first.reference;
      final userData = userQuerySnapshot.docs.first.data();
      final fullName = '${userData['name']} ${userData['lastName']}';

      await userDocRef.update({
        'memberOf': FieldValue.arrayUnion([committeeName])
      });

      setState(() {
        if (_activeMembers.containsKey(username)) {
          _activeMembers[username]['name'] = fullName;
        } else if (_inactiveMembers.containsKey(username)) {
          _inactiveMembers[username]['name'] = fullName;
        }
      });
    }
  }

  Future<void> _removeCommitteeFromUser(String username, String committeeName) async {
    final userQuerySnapshot = await FirebaseFirestore.instance.collection('activeUsers').where('username', isEqualTo: username).get();
    if (userQuerySnapshot.docs.isNotEmpty) {
      final userDocRef = userQuerySnapshot.docs.first.reference;

      await userDocRef.update({
        'memberOf': FieldValue.arrayRemove([committeeName])
      });

      setState(() {
        if (_activeMembers.containsKey(username)) {
          _activeMembers[username]['name'] = "";
        } else if (_inactiveMembers.containsKey(username)) {
          _inactiveMembers[username]['name'] = "";
        }
      });
    }
  }

  Future<void> _updateMemberStatus(String? username, Map<String, dynamic> member, bool isActive) async {
    if (username == null) return;

    final docRef = FirebaseFirestore.instance.collection('komiteer').doc(_selectedCommitteeId);

    final memberData = {
      'joined': member['joined'],
      'left': member['left'],
      'biography': member['biography'],
      'roles': member['roles'],
      'username': username,
      'name': member['name'],
    };

    if (isActive) {
      await docRef.update({
        'activeMembers.$username': memberData,
        'unactiveMembers.$username': FieldValue.delete(),
      });
    } else {
      await docRef.update({
        'unactiveMembers.$username': memberData,
        'activeMembers.$username': FieldValue.delete(),
      });
    }
  }

  Future<void> _editCommittee() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('komiteer').doc(_selectedCommitteeId).update({
        'name': _nameController.text,
        'about': _aboutController.text,
        'email': _emailController.text,
        'logo': _logoController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Committee updated successfully!')),
      );

      Navigator.pop(context);
    }
  }
}
