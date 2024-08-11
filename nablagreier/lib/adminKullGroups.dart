import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AdminKullGroupsPage extends StatefulWidget {
  @override
  _AdminKullGroupsPageState createState() => _AdminKullGroupsPageState();
}

class _AdminKullGroupsPageState extends State<AdminKullGroupsPage> {
  final _nameController = TextEditingController();

  Future<void> _addKullGroup() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a name')),
      );
      return;
    }

    final String uid = Uuid().v4();
    await FirebaseFirestore.instance.collection('Kull').doc(uid).set({
      'uid': uid,
      'name': _nameController.text,
      'createdAt': Timestamp.now(),
      'members': [],
      'rights': [], // Initialize the rights field as an empty array
    });

    _nameController.clear();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Kull group added successfully!')),
    );
  }

  Future<void> _deleteKullGroup(DocumentSnapshot group) async {
    await FirebaseFirestore.instance.collection('Kull').doc(group.id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Kull group deleted successfully!')),
    );
  }

  void _showAddKullGroupDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Kull Group'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Group Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: _addKullGroup,
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToGroupDetails(DocumentSnapshot group) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KullGroupDetailsPage(group: group)),
    );
  }

  void _showDeleteConfirmationDialog(DocumentSnapshot group) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Kull Group'),
          content: Text('Are you sure you want to delete this group?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteKullGroup(group);
                Navigator.pop(context);
              },
              child: Text('Delete'),
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
        title: Text('Kullgrupper'),
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
              ElevatedButton(
                onPressed: _showAddKullGroupDialog,
                child: Text('Add Kull Group'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1045A6),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Kull').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final kullGroups = snapshot.data!.docs;

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        crossAxisSpacing: 20, // Increased spacing between columns
                        mainAxisSpacing: 20, // Increased spacing between rows
                      ),
                      itemCount: kullGroups.length,
                      itemBuilder: (context, index) {
                        final group = kullGroups[index];
                        final members = group['members'] as List;

                        return GestureDetector(
                          onTap: () => _navigateToGroupDetails(group),
                          onLongPress: () => _showDeleteConfirmationDialog(group),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    group['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '${members.length} members',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KullGroupDetailsPage extends StatefulWidget {
  final DocumentSnapshot group;

  KullGroupDetailsPage({required this.group});

  @override
  _KullGroupDetailsPageState createState() => _KullGroupDetailsPageState();
}

class _KullGroupDetailsPageState extends State<KullGroupDetailsPage> {
  final _memberSearchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  List<dynamic> _members = [];

  @override
  void initState() {
    super.initState();
    _members = widget.group['members'];
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

    await FirebaseFirestore.instance.collection('Kull').doc(widget.group.id).update({
      'members': FieldValue.arrayUnion([memberId]),
    });

    setState(() {
      _members.add(memberId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Member added successfully!')),
    );
  }

  Future<void> _removeMemberFromGroup(String memberId) async {
    await FirebaseFirestore.instance.collection('Kull').doc(widget.group.id).update({
      'members': FieldValue.arrayRemove([memberId]),
    });

    setState(() {
      _members.remove(memberId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Member removed successfully!')),
    );
  }

  Future<void> _deleteKullGroup() async {
    await FirebaseFirestore.instance.collection('Kull').doc(widget.group.id).delete();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Kull group deleted successfully!')),
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Kull Group'),
          content: Text('Are you sure you want to delete this group?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteKullGroup();
                Navigator.pop(context);
              },
              child: Text('Delete'),
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
        title: Text('Edit ${widget.group['name']}'),
        backgroundColor: Color(0xFF1045A6),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _showDeleteConfirmationDialog,
          ),
        ],
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
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    var user = _searchResults[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(user['name'] ?? 'No Name'),
                      subtitle: Text(user['email'] ?? 'No Email'),
                      onTap: () => _addMemberToGroup(user['uid']),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text('Members:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: _members.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('activeUsers').doc(_members[index]).get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        var user = snapshot.data!.data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(user['name'] ?? 'No Name'),
                          subtitle: Text(user['email'] ?? 'No Email'),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () => _removeMemberFromGroup(_members[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
