import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';  // Import intl for date formatting
import 'adminMakeEvent.dart';

class EventListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('events')
              .orderBy('createdAt', descending: true) // Sorting by createdAt field
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final events = snapshot.data?.docs ?? [];

            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final eventName = event['name'];
                final eventId = event.id;
                final Timestamp createdAt = event['createdAt'];
                final DateTime dateTime = createdAt.toDate();
                final formattedDate = DateFormat('dd/MM/yyyy, HH:mm').format(dateTime);

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(eventName),
                    subtitle: Text('Created at: $formattedDate'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminMakeEventPage(eventId: eventId),
                          ),
                        );
                      },
                      child: Text('Edit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1045A6),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
