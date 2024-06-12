//main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'top_image_section.dart';
import 'sticky_header.dart';
import 'kommende_arrangement.dart';
import 'flere_arrangementer.dart';

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
      theme: ThemeData.light(), // Define light theme
      darkTheme: ThemeData.dark(), // Define dark theme
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
            
            /*
            SliverToBoxAdapter(
              child: CardCarousel(), // Your carousel widget
            ),
            */
            FlereArrangementer(),
            SliverPadding(
              padding: EdgeInsets.only(top: 50),
            ),
          ],
        ),
      ),
    );
  }
}







class CardCarousel extends StatelessWidget {
  // Assuming you have a list of items with dates that you want to display in the carousel.
  // This list should be sorted by date beforehand.
  final List<MyCardItem> items = [
    MyCardItem(title: 'Event 1', date: '2024-03-25'),
    MyCardItem(title: 'Event 2', date: '2024-03-26'),
    MyCardItem(title: 'Event 3', date: '2024-03-27'),
    MyCardItem(title: 'Event 4', date: '2024-03-28'),
  ]..sort((a, b) => a.date.compareTo(b.date)); // Sorting by date in ascending order.

  @override
  Widget build(BuildContext context) {
    // Adjust viewportFraction to show multiple cards. For example, 0.3 will show 3 cards.
    double viewportFraction = 1/10;
    return CarouselSlider.builder(
      itemCount: items.length, // Use the sorted list's length
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return MyCard(
          title: items[itemIndex].title,
          date: items[itemIndex].date,
        );
      },
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: false,
        viewportFraction: viewportFraction,
        aspectRatio: 10, // Adjust aspect ratio for shorter cards
        initialPage: 0,
        enableInfiniteScroll: false, // Set to false to prevent looping
      ),
    );
  }
}

// A simple data class to represent your card items.
class MyCardItem {
  final String title;
  final String date;

  MyCardItem({required this.title, required this.date});
}

class MyCard extends StatelessWidget {
  final String title;
  final String date;

  MyCard({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use the minimum amount of space
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              'https://via.placeholder.com/150', // Replace with your image URL or asset
              height: 100, // Set a fixed height for the image
              width: double.infinity, // Make the image take up the full card width
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(title),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(date),
          ),
        ],
      ),
    );
  }
}
