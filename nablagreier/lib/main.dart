//main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'top_image_section.dart'; 
import 'sticky_header.dart';
import 'kommende_arrangement.dart';
import 'flere_arrangementer.dart';
import 'nabladet.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyWebPage(),
    ),
  );
}

class MyWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: themeProvider.antiTextColor), // Define light theme
      darkTheme: ThemeData(scaffoldBackgroundColor: themeProvider.antiTextColor), // Define dark theme
      themeMode: themeProvider.themeMode, // Use the theme from the provider
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            
            StickyHeader(),                     // Sticky header that remains visible as you scroll
            
            TopImageSection(),         // This is the top image that will scroll away.
            
            
            SliverPadding(
              padding: EdgeInsets.only(top: 80),
            ),
            
            KommendeArrangement(),
            
            SliverPadding(
              padding: EdgeInsets.only(top: 80),
            ),
            
            FlereArrangementer(),
            SliverPadding(
              padding: EdgeInsets.only(top: 50),
            ),
            NyesteNabladet(),
          ],
        ),
      ),
    );
  }
}
