import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'top_image_section.dart';
import 'sticky_header.dart';
import 'kommende_arrangement.dart';
import 'flere_arrangementer.dart';
import 'login.dart';
import 'register.dart';
import 'admin.dart';
import 'firebase_options.dart';
import 'eventDetail.dart'; // Import the new event detail page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/admin': (context) => AdminPage(),
        // Define a route for the event detail page
        '/eventDetail': (context) => EventDetailPage(eventData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
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
          StickyHeader(),
          TopImageSection(),
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
