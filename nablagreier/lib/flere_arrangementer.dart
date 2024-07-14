import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'eventDetail.dart'; // Import the event detail page

class FlereArrangementer extends StatelessWidget {
  const FlereArrangementer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 4 / 5,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('events')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData) {
                return Text('No events found');
              }

              List<DocumentSnapshot> documents = snapshot.data!.docs;
              List<Widget> arrangementer = [];
              List<Widget> bedpres = [];

              for (var doc in documents) {
                var data = doc.data() as Map<String, dynamic>;
                var eventName = data['name'];
                var eventDate = data['startDate'];
                var eventType = data['type'];
                var registrationCloseDate = data['registrationCloseDate'];
                var numberOfSpots = data['numberOfSpots'] ?? 'N/A';
                var participantList = data['participantList'] ?? [];
                var spotsTaken = participantList.length;

                var eventWidget = GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/eventDetail',
                      arguments: data,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 40),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 3 / 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                eventName,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: MediaQuery.of(context).size.width / 60,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                eventDate,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: MediaQuery.of(context).size.width / 70,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 100),
                        Container(
                          width: MediaQuery.of(context).size.width * 3 / 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Påmelding innen $registrationCloseDate',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: MediaQuery.of(context).size.width / 90,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFDBEEFF),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                '$spotsTaken/$numberOfSpots',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: MediaQuery.of(context).size.width / 90,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFDBEEFF),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                if (eventType == 'bedpres') {
                  bedpres.add(eventWidget);
                } else {
                  arrangementer.add(eventWidget);
                }
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 3 / 8,
                        child: Text(
                          'Arrangementer',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: MediaQuery.of(context).size.width / 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      ...arrangementer,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 3 / 8,
                        child: Text(
                          'Bedriftspresentasjoner',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: MediaQuery.of(context).size.width / 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      ...bedpres,
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
