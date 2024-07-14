import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admission extends StatefulWidget {
  final String userId;

  const Admission({Key? key, required this.userId}) : super(key: key);

  @override
  _AdmissionState createState() => _AdmissionState();
}

class _AdmissionState extends State<Admission> {
  Map<String, String> committeeNotes = {};
  Map<String, TextEditingController> textControllers = {};
  List<String> selectedCommittees = [];

  Future<bool> _isApplicationActive() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('groupAdmissions')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      var data = doc.data() as Map<String, dynamic>?;
      if (data != null && data['status'] == true) {
        return true;
      }
    }
    return false;
  }

  Future<String?> _fetchClosedAtDate() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('groupAdmissions')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      var data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        var closedAt = (data['closedAt'] as Timestamp).toDate();
        return "${closedAt.day}-${closedAt.month}-${closedAt.year}";
      }
    }
    return null;
  }

  Future<void> _fetchUserApplications(String userName) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('groupAdmissions')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      var data = doc.data() as Map<String, dynamic>?;

      if (data != null) {
        var committees = data['committees'] as List<dynamic>;
        for (var committee in committees) {
          var applications = data[committee] as List<dynamic>;
          for (var application in applications) {
            if (application.containsKey(userName)) {
              selectedCommittees.add(committee);
              committeeNotes[committee] = application[userName];
              textControllers[committee] = TextEditingController(text: application[userName]);
            }
          }
        }
      }
    }
  }

  void _showPopup(BuildContext context) async {
    String? closedAtDate = await _fetchClosedAtDate();

    // Fetch the user name from the activeUsers collection
    var userDoc = await FirebaseFirestore.instance
        .collection('activeUsers')
        .doc(widget.userId)
        .get();

    String? userName;
    if (userDoc.exists) {
      userName = userDoc.data()?['username'];
    } else {
      userName = 'Unknown User';
    }

    await _fetchUserApplications(userName!);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Søk undergruppe',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Du kan søke undergrupper ved å velge komiteer nedenfor. Du kan alltid endre registreringen din før fristen utløper. Fristen er $closedAtDate',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('groupAdmissions')
                            .orderBy('createdAt', descending: true)
                            .limit(1)
                            .snapshots()
                            .map((snapshot) => snapshot.docs.first),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          var data = snapshot.data?.data() as Map<String, dynamic>?;
                          if (data == null) {
                            return Center(child: Text('No committees found'));
                          }

                          var committees = data['committees'] as List<dynamic>;
                          List<Widget> committeeWidgets = [];
                          for (int i = 0; i < committees.length; i += 2) {
                            List<Widget> rowWidgets = [];
                            for (int j = i; j < i + 2 && j < committees.length; j++) {
                              var committeeName = committees[j];
                              var isSelected = selectedCommittees.contains(committeeName);
                              if (!textControllers.containsKey(committeeName)) {
                                textControllers[committeeName] = TextEditingController();
                              }
                              rowWidgets.add(
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (selectedCommittees.contains(committeeName)) {
                                          selectedCommittees.remove(committeeName);
                                          committeeNotes.remove(committeeName);
                                          textControllers.remove(committeeName);
                                        } else {
                                          selectedCommittees.add(committeeName);
                                          committeeNotes[committeeName] = '';
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: isSelected ? Color.fromARGB(255, 2, 158, 255) : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.black),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            committeeName,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: isSelected ? Colors.black : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          if (isSelected)
                                            Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Text(
                                                  'Dette feltet er ikke obligatorisk, med mindre du søker en musikalsk gruppe, hvor du må skrive hvilket instrument du spiller.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                TextField(
                                                  maxLength: 100,
                                                  controller: textControllers[committeeName],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      committeeNotes[committeeName] = value;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: 'Skriv her...',
                                                    border: OutlineInputBorder(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            committeeWidgets.add(Row(children: rowWidgets));
                          }
                          return SingleChildScrollView(
                            child: Column(children: committeeWidgets),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          var docRef = await FirebaseFirestore.instance
                              .collection('groupAdmissions')
                              .orderBy('createdAt', descending: true)
                              .limit(1)
                              .get()
                              .then((snapshot) => snapshot.docs.first.reference);

                          var docSnapshot = await docRef.get();
                          var docData = docSnapshot.data() as Map<String, dynamic>?;

                          if (docData != null) {
                            for (String committee in docData['committees']) {
                              var committeeApplications = List<Map<String, dynamic>>.from(docData[committee] ?? []);

                              // Check if there is any existing application by the user
                              var existingApplicationIndex = committeeApplications.indexWhere((application) => application.containsKey(userName));

                              if (existingApplicationIndex != -1) {
                                // User has an existing application
                                if (selectedCommittees.contains(committee)) {
                                  // Update the existing application with the new note, even if it's an empty string
                                  committeeApplications[existingApplicationIndex][userName!] = committeeNotes[committee] ?? '';
                                } else {
                                  // Remove the application if the user has deselected the committee
                                  committeeApplications.removeAt(existingApplicationIndex);
                                }
                              } else {
                                // New application
                                if (selectedCommittees.contains(committee)) {
                                  var newApplication = {
                                    userName!: committeeNotes[committee] ?? ''
                                  };
                                  committeeApplications.add(newApplication);
                                }
                              }

                              await docRef.update({
                                committee: committeeApplications,
                              });
                            }
                          }

                          // Print the userName and UID of the current logged-in user
                          print('User Name: $userName, User ID: ${widget.userId}');

                          // Show confirmation to the user
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Din søknad er sendt!'),
                            ),
                          );

                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFFDBEEFF),
                          backgroundColor: const Color(0xFF1045A6),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          textStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        child: Text('Send søknad'),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isApplicationActive(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return SliverToBoxAdapter(
            child: Center(
              child: Container(
                height: 260,
                width: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 400,
                      child: Text(
                        'Undergruppeopptak',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 36,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<String?>(
                      future: _fetchClosedAtDate(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return Text('No date found');
                        } else {
                          return Container(
                            width: 400,
                            child: Text(
                              'Du kan søke undergrupper ved å klikke på knappen under. Fristen er ${snapshot.data}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          );
                        }
                      },
                    ),
                    Spacer(),
                    Container(
                      width: 400,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFDBEEFF),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF1045A6),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        onPressed: () => _showPopup(context),
                        child: const Text(
                          'søk undergruppe',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SliverToBoxAdapter(
          );
        }
      },
    );
  }
}
