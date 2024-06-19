import 'package:flutter/material.dart';
import 'sticky_header.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          StickyHeader(),
          SliverPadding(padding: EdgeInsets.only(top: 80)),
        ],
      ),
    );
  }
}
