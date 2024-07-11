import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminUserRequestsPage extends StatefulWidget {
  @override
  _AdminUserRequestsPageState createState() => _AdminUserRequestsPageState();
}

class _AdminUserRequestsPageState extends State<AdminUserRequestsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int _limit = 50;
  bool _isAscending = true;

  Future<void> _dismissUserRequest(String userId) async {
    try {
      await _firestore.collection('userRequests').doc(userId).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to dismiss request: $e'),
      ));
    }
  }

  Future<void> _acceptUserRequest(DocumentSnapshot userRequest) async {
    try {
      final data = userRequest.data() as Map<String, dynamic>;
      final userId = userRequest.id;

      data.remove('status');
      data['uid'] = userId;
      data['name'] = '';  
      data['lastName'] = '';  
      data['memberOf'] = [];  
      data['superUser'] = false;  
      data['adminAccess'] = [];  
      data['civilStatus'] = '';  
      data['cardNumber'] = 0;  
      data['birthDate'] = "";  
      data['biography'] = "";  
      data['profilePicture'] = '';  
      data['lastLogin'] = "";  
      data['hobbies'] = [];  
      data['favoriteQuotes'] = [];  
      data['badges'] = [];  
      data['theme'] = '';  
      data['socialLinks'] = {}; 
      data['origin'] = ''; 
      data['class'] = ''; 

      // Add the new document to the activeUsers collection
      await _firestore.collection('activeUsers').doc(userId).set(data);

      // Delete the original request
      await _firestore.collection('userRequests').doc(userId).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to accept request: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registreringsforespørsler'),
        backgroundColor: const Color(0xFF1045A6),
        actions: [
          IconButton(
            icon: Icon(_isAscending ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: () {
              setState(() {
                _isAscending = !_isAscending;
              });
            },
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
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('userRequests')
              .orderBy('createdAt', descending: !_isAscending)
              .limit(_limit)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final userRequests = snapshot.data?.docs ?? [];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Username', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Created At', style: TextStyle(fontWeight: FontWeight.bold))),
                        Text('Activate', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Dismiss', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: userRequests.length,
                      itemBuilder: (context, index) {
                        final userRequest = userRequests[index];
                        final email = userRequest['email'];
                        final username = userRequest['username'];
                        final createdAt = userRequest['createdAt'].toDate();
                        final status = userRequest['status'];
                        final formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(createdAt);

                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 5,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(email)),
                              Expanded(child: Text(username)),
                              Expanded(child: Text(formattedDate)),
                              Switch(
                                value: status,
                                activeColor: const Color(0xFF1045A6),
                                onChanged: (bool value) {
                                  if (value) {
                                    _acceptUserRequest(userRequest);
                                  }
                                },
                              ),
                              const SizedBox(width: 10), // Added spacing
                              Switch(
                                value: false,
                                activeColor: Colors.red,
                                onChanged: (bool value) {
                                  if (value) {
                                    _dismissUserRequest(userRequest.id);
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
