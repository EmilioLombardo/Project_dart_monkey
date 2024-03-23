import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'top_image_section.dart'; 
import 'sticky_header.dart';
import 'kommende_arrangement.dart';

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
      theme: ThemeData.light(), // Define light theme
      darkTheme: ThemeData.dark(), // Define dark theme
      themeMode: themeProvider.themeMode, // Use the theme from the provider
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            
            TopImageSection(),         // This is the top image that will scroll away.
            
            StickyHeader(),                     // Sticky header that remains visible as you scroll
            
            SliverPadding(
              padding: EdgeInsets.only(top: 80),
            ),
            
            KommendeArrangement(),
            
          ],
        ),
      ),
    );
  }
}
