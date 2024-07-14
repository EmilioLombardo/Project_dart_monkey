import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailPage extends StatefulWidget {
  final Map<String, dynamic> eventData;

  const EventDetailPage({Key? key, required this.eventData}) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late List<dynamic> participantList;
  late List<dynamic> waitingList;
  late String eventId;
  String buttonLabel = 'Meld deg på';
  Color buttonColor = Colors.white;
  bool isUserInList = false;
  User? currentUser;
  String? userName;

  @override
  void initState() {
    super.initState();
    participantList = widget.eventData['participantList'] ?? [];
    waitingList = widget.eventData['waitingList'] ?? [];
    eventId = widget.eventData['uid'] ?? ''; // Ensure the event ID is correctly assigned and handle null
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _fetchUserName();
    }
  }

  Future<void> _fetchUserName() async {
    if (currentUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('activeUsers')
          .doc(currentUser!.uid)
          .get();

      if (userSnapshot.exists) {
        userName = userSnapshot['name'];
        if (participantList.contains(userName) || waitingList.contains(userName)) {
          setState(() {
            isUserInList = true;
            buttonLabel = participantList.length >= widget.eventData['numberOfSpots']
                ? 'Meld deg av venteliste'
                : 'Meld deg av';
            buttonColor = Colors.black;
          });
        } else {
          setState(() {
            buttonLabel = participantList.length >= widget.eventData['numberOfSpots']
                ? 'Meld deg på venteliste'
                : 'Meld deg på';
            buttonColor = Colors.white;
          });
        }
      }
    }
  }

  Future<void> _toggleUserInEvent() async {
    if (currentUser != null && eventId.isNotEmpty) {
      // Fetch the user's name from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('activeUsers')
          .doc(currentUser!.uid)
          .get();

      if (userSnapshot.exists) {
        String userName = userSnapshot['name'];

        if (participantList.contains(userName) || waitingList.contains(userName)) {
          // Remove the user from the lists
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentReference eventDocRef = FirebaseFirestore.instance.collection('events').doc(eventId);
            DocumentSnapshot eventSnapshot = await transaction.get(eventDocRef);

            if (eventSnapshot.exists) {
              List<dynamic> currentParticipants = List.from(eventSnapshot['participantList'] ?? []);
              List<dynamic> currentWaitingList = List.from(eventSnapshot['waitingList'] ?? []);

              currentParticipants.remove(userName);
              currentWaitingList.remove(userName);

              transaction.update(eventDocRef, {
                'participantList': currentParticipants,
                'waitingList': currentWaitingList,
              });
            }
          }).then((_) {
            setState(() {
              participantList.remove(userName);
              waitingList.remove(userName);
              isUserInList = false;
              buttonLabel = participantList.length >= widget.eventData['numberOfSpots']
                  ? 'Meld deg på venteliste'
                  : 'Meld deg på';
              buttonColor = Colors.white;
            });
          }).catchError((error) {});
        } else {
          // Add the user to the lists
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentReference eventDocRef = FirebaseFirestore.instance.collection('events').doc(eventId);
            DocumentSnapshot eventSnapshot = await transaction.get(eventDocRef);

            if (eventSnapshot.exists) {
              List<dynamic> currentParticipants = List.from(eventSnapshot['participantList'] ?? []);
              List<dynamic> currentWaitingList = List.from(eventSnapshot['waitingList'] ?? []);

              if (currentParticipants.length < widget.eventData['numberOfSpots']) {
                // Add to participantList
                currentParticipants.add(userName);
              } else {
                // Add to waitingList
                currentWaitingList.add(userName);
              }

              transaction.update(eventDocRef, {
                'participantList': currentParticipants,
                'waitingList': currentWaitingList,
              });
            }
          }).then((_) {
            setState(() {
              if (participantList.length < widget.eventData['numberOfSpots']) {
                participantList.add(userName);
              } else {
                waitingList.add(userName);
              }
              isUserInList = true;
              buttonLabel = participantList.length >= widget.eventData['numberOfSpots']
                  ? 'Meld deg av venteliste'
                  : 'Meld deg av';
              buttonColor = Colors.black;
            });
          }).catchError((error) {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gather additional information fields
    final additionalInfoFields = [
      if ((widget.eventData['cancellationPolicy'] ?? '').isNotEmpty)
        _buildDetailRow(Icons.rule, 'Cancellation Policy', widget.eventData['cancellationPolicy']),
      if ((widget.eventData['dressCode'] ?? '').isNotEmpty)
        _buildDetailRow(Icons.code, 'Dress Code', widget.eventData['dressCode']),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventData['name'] ?? 'Event Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: _buildImageCard(widget.eventData['imageURL']),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(Icons.event, 'Name', widget.eventData['name']),
                        _buildClickableDetailRow(Icons.location_on, 'Location', widget.eventData['place'], widget.eventData['locationDetails']),
                        _buildDetailRow(Icons.event, 'Start', '${widget.eventData['startDate']} at ${widget.eventData['startTime']}'),
                        _buildDetailRow(Icons.event, 'End', '${widget.eventData['endDate']} at ${widget.eventData['endTime']}'),
                        _buildDetailRow(Icons.people, 'Number of Spots', '${participantList.length}/${widget.eventData['numberOfSpots']}'),
                        _buildDetailRow(Icons.check_circle, 'Open For', widget.eventData['openFor'] is Map && widget.eventData['openFor']['students'] is bool && widget.eventData['openFor']['students'] ? 'Students' : 'Alumni'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.eventData['description'] ?? 'No description available',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Contact Information'),
                        _buildDetailCard([
                          _buildDetailRow(Icons.contact_mail, 'Contact Email', widget.eventData['contactEmail']),
                          _buildDetailRow(Icons.phone, 'Contact Phone', widget.eventData['contactPhone']),
                          _buildDetailRow(Icons.business, 'Host', widget.eventData['host']),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Payment Information'),
                        _buildDetailCard([
                          _buildDetailRow(Icons.attach_money, 'Price', '${widget.eventData['price']}'),
                          _buildDetailRow(Icons.money, 'Payment Details', widget.eventData['paymentDetails']),
                          _buildDetailRow(Icons.account_balance, 'Account Number', '${widget.eventData['accountNumber']}'),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              _buildBlueBox(
                title: 'Sign Up',
                buttonLabel: buttonLabel,
                participantsSection: _buildParticipantsSection('Participants', participantList),
                waitingListSection: _buildParticipantsSection('Waiting List', waitingList),
              ),
              SizedBox(height: 16.0),
              if (additionalInfoFields.isNotEmpty)
                ...[
                  _buildSectionTitle('Additional Information'),
                  _buildDetailCard(additionalInfoFields),
                ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String? imageURL) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 400.0, // Increase the height to make it more prominent
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageURL ?? ''),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
    );
  }

  Widget _buildDetailCard(List<Widget> children) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String? info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  info ?? 'Not available',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableDetailRow(IconData icon, String title, String? info, String? link) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                GestureDetector(
                  onTap: () {
                    if (link != null && link.isNotEmpty) {
                      launch(link);
                    }
                  },
                  child: Text(
                    info ?? 'Not available',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlueBox({
    required String title,
    required String buttonLabel,
    required Widget participantsSection,
    required Widget waitingListSection,
  }) {
    return Card(
      color: const Color(0xFF051752),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: _toggleUserInEvent,
                child: Text(buttonLabel),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            participantsSection,
            SizedBox(height: 16.0),
            waitingListSection,
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantsSection(String title, List<dynamic>? participants) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        Wrap(
          spacing: 8.0, // Horizontal space between children
          runSpacing: 4.0, // Vertical space between runs
          children: participants != null && participants.isNotEmpty
              ? participants.map((participant) => _buildParticipantChip(participant)).toList()
              : [_buildParticipantChip('No participants')],
        ),
      ],
    );
  }

  Widget _buildParticipantChip(String participant) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        participant,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
