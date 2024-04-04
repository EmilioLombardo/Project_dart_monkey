//main.dart
import 'package:flutter/material.dart';
import 'package:nablagreier/app_colors.dart';
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
            /*
            SliverToBoxAdapter(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //backgroundColor
                  //textColor
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    color: themeProvider.backgroundColor,
                    child: Column(
                      children: [
                        //700
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //500
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //400
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //300
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //backgroundColor
                  //antiTextColor
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    color: themeProvider.backgroundColor,
                    child: Column(
                      children: [
                        //700
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        //500
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        //400
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        //300
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //antiBackgroundColor
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    color: themeProvider.antiBackgroundColor,
                    child: Column(
                      children: [
                        //700
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //500
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //400
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //300
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            ),
            SliverToBoxAdapter(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //backgroundColor
                  //textColor
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    color: themeProvider.backgroundColor,
                    child: Column(
                      children: [
                        //700
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //500
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //400
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //300
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //backgroundColor
                  //antiTextColor
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    color: themeProvider.backgroundColor,
                    child: Column(
                      children: [
                        //700
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        //500
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        //400
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        //300
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.antiTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //antiBackgroundColor
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    color: themeProvider.antiBackgroundColor,
                    child: Column(
                      children: [
                        //700
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //500
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //400
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                        //300
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            color: themeProvider.textColor,
                          ),
                        ),
                        Text(
                          'Sample Text',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            color: themeProvider.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
