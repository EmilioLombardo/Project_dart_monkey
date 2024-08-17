import 'package:flutter/material.dart';
import 'package:nablagreier/adminEditCommittee.dart';
import 'adminUserRequests.dart'; // Import the AdminUserRequestsPage
import 'adminMakeEvent.dart'; // Import the AdminMakeEventPage
import 'eventList.dart'; // Import the EventListPage
import 'adminAddCommittee.dart'; // Import the AdminAddCommitteePage
import 'adminGroupAdmission.dart'; // Import the AdminGroupAdmissionPage
import 'adminActiveUsers.dart'; // Import the AdminActiveUsersPage
import 'adminAddAdminGroup.dart'; // Import the AdminAddAdminGroupPage
import 'adminEditAdminGroup.dart'; // Import the AdminEditAdminGroupPage
import 'adminEditRights.dart'; // Import the AdminEditRightsPage
import 'adminKullGroups.dart'; // Import the AdminKullGroupsPage

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<String> moduleNames = [
    'Administrer Brukere', // Custom name for the first module
    'Administrer Arrangement',
    'Administrer Komiteer',
    'Admin Tilganger', // New module name
  ];

  final Map<String, List<String>> moduleOptions = {
    'Administrer Brukere': ['Registreringsforespørsler', 'Aktive Brukere', 'Kullgrupper'],
    'Administrer Arrangement': ['Legg til arrangement', 'Arrangement liste', 'Option 3'],
    'Administrer Komiteer': ['Legg til komité', 'Rediger Komité', 'Undergruppeopptak'],
    'Admin Tilganger': ['Adminstrer tilganger', 'Legg til egendefinert gruppe', 'Rediger rettigheter'], // Renamed options
  };

  String? _expandedModule;

  void _navigateToOption(BuildContext context, String option) {
    if (option == 'Registreringsforespørsler') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminUserRequestsPage()),
      );
    } else if (option == 'Aktive Brukere') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminActiveUsersPage()), // Navigate to AdminActiveUsersPage
      );
    } else if (option == 'Kullgrupper') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminKullGroupsPage()), // Navigate to AdminKullGroupsPage
      );
    } else if (option == 'Legg til arrangement') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminMakeEventPage()),
      );
    } else if (option == 'Arrangement liste') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EventListPage()),
      );
    } else if (option == 'Legg til komité') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminAddCommitteePage()),
      );
    } else if (option == 'Rediger Komité') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminEditCommitteePage()), // Add the navigation
      );
    } else if (option == 'Undergruppeopptak') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminGroupAdmissionPage()), // Add the navigation
      );
    } else if (option == 'Adminstrer tilganger') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminEditAdminGroupPage()), // Add the navigation for AdminEditAdminGroupPage
      );
    } else if (option == 'Legg til egendefinert gruppe') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminAddAdminGroupPage()), // Add the navigation for AdminAddAdminGroupPage
      );
    } else if (option == 'Rediger rettigheter') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminEditRightsPage()), // Add the navigation for AdminEditRightsPage
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Clicked on $option'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Color(0xFF1045A6),
        elevation: 0,
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
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns
              crossAxisSpacing: 20, // Increased spacing between columns
              mainAxisSpacing: 20, // Increased spacing between rows
            ),
            itemCount: moduleNames.length, // Number of items in the grid
            itemBuilder: (context, index) {
              String moduleName = moduleNames[index];
              bool isExpanded = _expandedModule == moduleName;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedModule = isExpanded ? null : moduleName;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
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
                  child: Stack(
                    children: [
                      if (isExpanded)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Text(
                            moduleName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      if (!isExpanded)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.dashboard,
                                size: 50,
                                color: Color(0xFF1045A6),
                              ),
                              SizedBox(height: 10),
                              Text(
                                moduleName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      if (isExpanded)
                        Positioned.fill(
                          top: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: moduleOptions[moduleName]!
                                  .map((option) => Expanded(
                                        child: GestureDetector(
                                          onTap: () => _navigateToOption(context, option),
                                          child: AnimatedOpacity(
                                            duration: const Duration(milliseconds: 300),
                                            opacity: isExpanded ? 1.0 : 0.0,
                                            child: Container(
                                              margin: EdgeInsets.only(bottom: 8.0),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF0D47A1),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  option,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
