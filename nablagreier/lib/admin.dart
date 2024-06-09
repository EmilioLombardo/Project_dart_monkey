import 'package:flutter/material.dart';
import 'adminUserRequests.dart'; // Import the new page

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<String> moduleNames = [
    'Administrer Brukere', // Custom name for the first module
    'Administrer Arrangement',
    'Administrer Undergrupper',
  ];

  final Map<String, List<String>> moduleOptions = {
    'Administrer Brukere': ['Registreringsforespørsler', 'Option 2', 'Option 3'],
    'Administrer Arrangement': ['Option 1', 'Option 2', 'Option 3'],
    'Administrer Undergrupper': ['Option 1', 'Option 2', 'Option 3'],
  };

  String? _expandedModule;

  void _navigateToOption(BuildContext context, String option) {
    if (option == 'Registreringsforespørsler') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminUserRequestsPage()),
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
