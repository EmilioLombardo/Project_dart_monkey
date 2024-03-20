import 'package:flutter/material.dart';

void main() {
  runApp(MyWebPage());
}

class MyWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            // This is the top image that will scroll away.
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.width * 2 / 5, // 2/5 of the screen width
                decoration: const BoxDecoration(
                  color: Color(0xFFDBEEFF), // Background color of the top part
                  image: DecorationImage(
                    image: AssetImage('images/nablabakgrunn.jpg'), // Background image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    // Title with Custom Font
                    const Positioned(
                      top: 20, // Adjust the position based on your needs
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Nabla - Linjeforening for fysikk og matematikk',
                          style: TextStyle(
                            fontFamily: 'Satoshi', // Use your custom font
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Login Feature (Sign up and Sign in buttons)
                    Positioned(
                      bottom: 20, // Adjust the position based on your needs
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              // Handle Sign Up
                            },
                            child: Text('Sign Up'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle Sign In
                            },
                            child: Text('Sign In'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sticky header that remains visible as you scroll
            SliverPersistentHeader(
              delegate: _StickyHeaderDelegate(
                minHeight: 60.0,
                maxHeight: 60.0,
                child: Container(
                  color: Color(0xFF1045A6), // Background color of the header
                  child: Center(
                    child: Text(
                      'Sticky Header',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              pinned: true,
            ),
            // Your main content goes here, below the sticky header
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text('Item #$index'),
                ),
                childCount: 30, // Number of list items
              ),
            ),
          ],
        ),
      ),
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
