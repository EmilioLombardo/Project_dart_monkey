import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'theme_provider.dart';
import 'viewOthersProfilePage.dart';
import 'eventDetail.dart';
import '_globals.dart';

class StickyHeader extends StatefulWidget {
  const StickyHeader({Key? key}) : super(key: key);

  @override
  _StickyHeaderState createState() => _StickyHeaderState();
}

class _StickyHeaderState extends State<StickyHeader> {
  bool _isSearching = false;
  bool _searchingUsers = false;
  bool _searchingCommittees = false;
  bool _searchingEvents = false;
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.black.withOpacity(0.75),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_searchingUsers && !_searchingCommittees && !_searchingEvents)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Velg hva du vil søke etter',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    if (_searchingUsers || _searchingCommittees || _searchingEvents)
                      TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: _searchingUsers
                              ? 'søk brukere'
                              : _searchingCommittees
                                  ? 'søk komiteer'
                                  : _searchingEvents
                                      ? 'søk arrangement'
                                      : '',
                          hintStyle: const TextStyle(color: Colors.white70),
                          prefixIcon: const Icon(Icons.search, color: Colors.white70),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (query) {
                          if (query.isEmpty) {
                            setState(() {
                              _searchResults.clear();
                            });
                          } else {
                            if (_searchingUsers) {
                              _searchUsers(query, setState);
                            } else if (_searchingCommittees) {
                              _searchCommittees(query, setState);
                            } else if (_searchingEvents) {
                              _searchEvents(query, setState);
                            }
                          }
                        },
                      ),
                    const SizedBox(height: 20),
                    _searchResults.isEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildIconBox(Icons.account_circle, 'søk brukere', setState),
                              _buildIconBox(Icons.group, 'søk komiteer', setState),
                              _buildIconBox(Icons.event, 'søk arrangement', setState),
                            ],
                          )
                        : _buildSearchResults(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildIconBox(IconData? icon, String label, Function setState) {
    return InkWell(
      onTap: () {
        setState(() {
          if (icon == Icons.account_circle) {
            _searchingUsers = true;
            _searchingCommittees = false;
            _searchingEvents = false;
          } else if (icon == Icons.group) {
            _searchingCommittees = true;
            _searchingUsers = false;
            _searchingEvents = false;
          } else if (icon == Icons.event) {
            _searchingEvents = true;
            _searchingUsers = false;
            _searchingCommittees = false;
          }
        });
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: icon != null
                ? Icon(icon, size: 40, color: Colors.white)
                : null,
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      children: _searchResults.map((doc) {
        return ListTile(
          title: Text(
            doc['name'],
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: _searchingUsers
              ? Text(
                  doc['username'],
                  style: const TextStyle(color: Colors.white70),
                )
              : _searchingCommittees
                  ? Text(
                      "Members: ${doc['activeMembers'].length} active",
                      style: const TextStyle(color: Colors.white70),
                    )
                  : null,
          onTap: () {
            if (_searchingUsers) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewOthersProfilePage(userId: doc.id),
                ),
              );
            } else if (_searchingCommittees) {
            } else if (_searchingEvents) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailPage(eventData: doc.data() as Map<String, dynamic>),
                ),
              );
            }
          },
        );
      }).toList(),
    );
  }

  Future<void> _searchUsers(String query, Function setState) async {
    String lowerCaseQuery = query.toLowerCase();

    final results = await FirebaseFirestore.instance
        .collection('activeUsers')
        .get();

    final filteredResults = results.docs.where((doc) {
      final name = doc['name'].toString().toLowerCase();
      final lastName = doc['lastName'].toString().toLowerCase();
      final username = doc['username'].toString().toLowerCase();
      return name.contains(lowerCaseQuery) ||
          lastName.contains(lowerCaseQuery) ||
          username.contains(lowerCaseQuery);
    }).toList();

    setState(() {
      _searchResults = filteredResults;
    });
  }

  Future<void> _searchCommittees(String query, Function setState) async {
    String lowerCaseQuery = query.toLowerCase();

    final results = await FirebaseFirestore.instance
        .collection('komiteer')
        .get();

    final filteredResults = results.docs.where((doc) {
      final name = doc['name'].toString().toLowerCase();
      return name.contains(lowerCaseQuery);
    }).toList();

    setState(() {
      _searchResults = filteredResults;
    });
  }

  Future<void> _searchEvents(String query, Function setState) async {
    String lowerCaseQuery = query.toLowerCase();

    final results = await FirebaseFirestore.instance
        .collection('events')
        .get();

    final filteredResults = results.docs.where((doc) {
      final name = doc['name'].toString().toLowerCase();
      return name.contains(lowerCaseQuery);
    }).toList();

    setState(() {
      _searchResults = filteredResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isSystemDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final iconData = (themeProvider.themeMode == ThemeMode.system ? isSystemDarkMode : themeProvider.isDarkMode) ? Icons.light_mode : Icons.dark_mode;
    return SliverPersistentHeader(
      delegate: _StickyHeaderDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                NablaColor.nablaBlue,
                NablaColor.nablaBlue,
              ],
            )
          ),
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
          alignment: Alignment.centerRight,
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final User? user = snapshot.data;
              return Container(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Container(
                        height: 40,
                        width: 40,                        
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Grafisk_logo_vector_hvit.png'), // Background image
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(NablaColor.nablaGold, BlendMode.srcATop)
                          ),
                        ),
                      ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/about');
                          },
                          child: Text(
                            'Om Nabla',
                            style: NablaText.headerHeader(NablaColor.white),
                          ),
                        ),
                        const SizedBox(width: 30),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Arrangementer',
                            style: NablaText.headerHeader(NablaColor.white),
                          ),
                        ),
                        const SizedBox(width: 30),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'For bedrifter',
                            style: NablaText.headerHeader(NablaColor.white),
                          ),
                        ),
                        const SizedBox(width: 30),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Ny student?',
                            style: NablaText.headerHeader(NablaColor.white),
                          ),
                        ),
                        const SizedBox(width: 30),
                        if (user != null) ...[
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/admin');
                            },
                            child: Text(
                              'Admin',
                              style: NablaText.headerHeader(NablaColor.white),
                            ),
                          ),
                          const SizedBox(width: 30),
                        ],
                        IconButton(
                          icon: Icon(iconData),
                          color: Colors.white,
                          onPressed: () {
                            if (themeProvider.themeMode == ThemeMode.system) {
                              themeProvider.toggleTheme(!isSystemDarkMode);
                            } else {
                              themeProvider.toggleTheme(!themeProvider.isDarkMode);
                            }
                          },
                        ),
                        const SizedBox(width: 15),
                        IconButton(
                          icon: Icon(Icons.search, color: NablaColor.white),
                          onPressed: _showSearchDialog,
                        ),                      
                        if (user != null) ...[
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                            child: Icon(Icons.account_circle, size: 30.0, color: NablaColor.white),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Logged out successfully'),
                              ));
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: Text(
                              'Logg ut',
                              style: NablaText.tinyHeader(NablaColor.white),
                            ),
                          ),
                        ],
                      ],
                    )
                  ]
                )
              );
            },
          ),
        ),
      ),
      pinned: true,
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        child != oldDelegate.child;
  }
}
