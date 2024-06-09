import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'theme_provider.dart';

class StickyHeader extends StatefulWidget {
  const StickyHeader({Key? key}) : super(key: key);

  @override
  _StickyHeaderState createState() => _StickyHeaderState();
}

class _StickyHeaderState extends State<StickyHeader> {
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
          color: const Color(0xFF1045A6),
          padding: const EdgeInsets.only(right: 16.0),
          alignment: Alignment.centerRight,
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final User? user = snapshot.data;
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Om Nabla',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Arrangementer',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'For bedrifter',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Ny student?',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30),
                  if (user != null) ...[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/admin'); // Navigate to admin page
                      },
                      child: const Text(
                        'Admin',
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
                  if (user != null) ...[
                    InkWell(
                      onTap: () {},
                      child: const Icon(Icons.account_circle, size: 30.0, color: Colors.white),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Logged out successfully'),
                        ));
                        Navigator.pushReplacementNamed(context, '/'); // Refresh the page
                      },
                      child: const Text(
                        'Logg ut',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ],
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
