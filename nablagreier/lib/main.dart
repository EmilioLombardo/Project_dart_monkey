import 'package:flutter/material.dart';
import 'top_image_section.dart'; 
import 'sticky_header.dart';

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
            
            SliverToBoxAdapter(
              child: TopImageSection(),         // This is the top image that will scroll away.
            ),
            
            StickyHeader(),                     // Sticky header that remains visible as you scroll
            
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
