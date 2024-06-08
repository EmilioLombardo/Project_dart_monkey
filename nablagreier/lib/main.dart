import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'top_image_section.dart';
import 'sticky_header.dart';
import 'kommende_arrangement.dart';
import 'flere_arrangementer.dart';
import 'login.dart';
import 'register.dart'; // Import the register page
import 'firebase_options.dart'; // Import Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase with options
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Define light theme
      darkTheme: ThemeData.dark(), // Define dark theme
      themeMode: themeProvider.themeMode, // Use the theme from the provider
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(), // Define the home page
        '/login': (context) => LoginPage(), // Define the login page route
        '/register': (context) => RegisterPage(), // Define the register page route
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          StickyHeader(), // Sticky header that remains visible as you scroll
          TopImageSection(), // This is the top image that will scroll away.
          SliverPadding(padding: EdgeInsets.only(top: 80)),
          KommendeArrangement(),
          SliverPadding(padding: EdgeInsets.only(top: 80)),
          FlereArrangementer(),
          SliverPadding(padding: EdgeInsets.only(top: 50)),
        ],
      ),
    );
  }
}
