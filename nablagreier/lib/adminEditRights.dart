import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AdminEditRightsPage extends StatefulWidget {
  @override
  _AdminEditRightsPageState createState() => _AdminEditRightsPageState();
}

class _AdminEditRightsPageState extends State<AdminEditRightsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final String _uid = Uuid().v4(); // Generate a unique UID

  String? _selectedCategory;
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final snapshot = await FirebaseFirestore.instance.collection('adminRights').get();
    final categories = snapshot.docs.map((doc) => doc['category'] as String).toSet().toList();
    setState(() {
      _categories = categories;
    });
  }

  Future<void> _editRights() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('adminRights').doc(_uid).set({
        'uid': _uid,
        'name': _nameController.text,
        'description': _descriptionController.text,
        'category': _selectedCategory,
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rights updated successfully!')),
      );

      Navigator.pop(context);
    }
  }

  void _showAddCategoryDialog() {
    final TextEditingController _newCategoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Category'),
          content: TextField(
            controller: _newCategoryController,
            decoration: InputDecoration(labelText: 'Category Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_newCategoryController.text.isNotEmpty) {
                  setState(() {
                    _categories.add(_newCategoryController.text);
                    _selectedCategory = _newCategoryController.text;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
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
        title: Text('Rediger rettigheter'),
        backgroundColor: Color(0xFF1045A6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      hint: Text('Select Category'),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      items: _categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _showAddCategoryDialog,
                  ),
                ],
              ),
              SizedBox(height: 20),
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
              ElevatedButton(
                onPressed: _editRights,
                child: Text('Update Rights'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
                    final categories = rights.map((doc) => doc['category'] as String).toSet().toList();

                    return ListView(
                      children: categories.map((category) {
                        final categoryRights = rights.where((doc) => doc['category'] == category).toList();

                        return ExpansionTile(
                          title: Text(category),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateRights,
                child: Text('Update Rights'),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1045A6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
