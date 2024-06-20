import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final Map<String, dynamic> eventData;

  const EventDetailPage({Key? key, required this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventData['name']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(eventData['imageUrl'] ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/BernardMadoff.jpg/640px-BernardMadoff.jpg'),
              SizedBox(height: 16.0),
              Text(
                eventData['name'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(eventData['description']),
              SizedBox(height: 8.0),
              Text('Location: ${eventData['locationDetails']}'),
              Text('Start: ${eventData['startDate']} at ${eventData['startTime']}'),
              Text('End: ${eventData['endDate']} at ${eventData['endTime']}'),
              SizedBox(height: 8.0),
              Text('Contact: ${eventData['contactEmail']} / ${eventData['contactPhone']}'),
              SizedBox(height: 16.0),
              Text('Price: ${eventData['price']}'),
              Text('Number of Spots: ${eventData['numberOfSpots']}'),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }
}
