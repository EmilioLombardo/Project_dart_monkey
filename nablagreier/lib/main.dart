import 'package:flutter/material.dart';
import 'top_image_section.dart'; 


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
              child: TopImageSection(),
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
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
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
