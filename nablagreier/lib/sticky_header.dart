import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'theme_provider.dart';

class StickyHeader extends StatelessWidget {
  const StickyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Determine the current theme mode based on system settings
    final isSystemDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // Update your icon based on the system theme mode at runtime
    final iconData = (themeProvider.themeMode == ThemeMode.system ? isSystemDarkMode : themeProvider.isDarkMode) ? Icons.light_mode : Icons.dark_mode;

    return SliverPersistentHeader(
      delegate: _StickyHeaderDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Container(
          color: const Color(0xFF1045A6), // Background color of the header
          padding: const EdgeInsets.only(right: 16.0), // Add some padding on the right
          alignment: Alignment.centerRight, // Align the column to the right
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final User? user = snapshot.data; // Get the current user
              return Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align text to the right
                children: [
                  InkWell(
                    onTap: () {
                      // Navigate to 'Om Nabla' page
                    },
                    child: const Text(
                      'Om Nabla',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30), // Spacing between text widgets
                  InkWell(
                    onTap: () {
                      // Navigate to 'Arrangementer' page
                    },
                    child: const Text(
                      'Arrangementer',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30), // Spacing between text widgets
                  InkWell(
                    onTap: () {
                      // Navigate to 'For bedrifter' page
                    },
                    child: const Text(
                      'For bedrifter',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30), // Spacing between text widgets
                  InkWell(
                    onTap: () {
                      // Navigate to 'Ny student?' page
                    },
                    child: const Text(
                      'Ny student?',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30), // Spacing between text widgets
                  IconButton(
                    icon: Icon(iconData),
                    color: Colors.white,
                    onPressed: () {
                      // If system, toggle based on current system mode, else toggle normally
                      if (themeProvider.themeMode == ThemeMode.system) {
                        themeProvider.toggleTheme(!isSystemDarkMode);
                      } else {
                        themeProvider.toggleTheme(!themeProvider.isDarkMode);
                      }
                    },
                  ),
                  const SizedBox(width: 15), // Spacing between text widgets
                  if (user != null) ...[
                    InkWell(
                      onTap: () {
                        // Handle the profile icon tap
                      },
                      child: const Icon(Icons.account_circle, size: 30.0, color: Colors.white), // Profile icon
                    ),
                    const SizedBox(width: 15), // Spacing between text widgets
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
