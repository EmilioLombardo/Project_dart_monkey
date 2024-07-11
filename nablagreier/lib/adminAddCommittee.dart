import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AdminAddCommitteePage extends StatefulWidget {
  @override
  _AdminAddCommitteePageState createState() => _AdminAddCommitteePageState();
}

class _AdminAddCommitteePageState extends State<AdminAddCommitteePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _emailController = TextEditingController();
  final String _uid = Uuid().v4(); // Generate a unique UID

  Future<void> _addCommittee() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('komiteer').doc(_uid).set({
        'name': _nameController.text,
        'uid': _uid,
        'logo': '',
        'about': _aboutController.text,
        'email': _emailController.text,
        'activeMembers': {},
        'unactiveMembers': {},
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Committee added successfully!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legg til Komité'),
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
                controller: _aboutController,
                decoration: InputDecoration(labelText: 'About'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addCommittee,
                child: Text('Add Committee'),
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
