import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0,100,0,180),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Hva er Nabla?',
                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600 ,fontSize: 40, color: Colors.white),
                    ),
                    Text(
                      'Nabla er linjeforeningen for fysikk og matematikk',
                      style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 24, color: Colors.white),
                    ),  
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0,40,0,40),
              color: const Color(0xFF051752),
              child: Center( 
                child: Container(
                  height: 260, // 1/5 of the screen width
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Styret',
                          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 36, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 100),
                      SizedBox(
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(                      
                              onPressed: () {
                                // Handle Les mer
                              },
                              child: const Text(
                                'Les mer',
                                style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0,40,0,40),
              child: Center( 
                child: Container(
                  height: 260, // 1/5 of the screen width
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Undergrupper',
                          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 36, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 100),
                      SizedBox(
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(                      
                              onPressed: () {
                                // Handle Les mer
                              },
                              child: const Text(
                                'Les mer',
                                style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0,40,0,40),
              color: const Color(0xFF051752),
              child: Center( 
                child: Container(
                  height: 260, // 1/5 of the screen width
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Tillitsvalgte',
                          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 36, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 100),
                      SizedBox(
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(                      
                              onPressed: () {
                                // Handle Les mer
                              },
                              child: const Text(
                                'Les mer',
                                style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0,40,0,40),
              child: Center( 
                child: Container(
                  height: 260, // 1/5 of the screen width
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Lover og forskrifter',
                          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 36, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 100),
                      SizedBox(
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(                      
                              onPressed: () {
                                // Handle Les mer
                              },
                              child: const Text(
                                'Les mer',
                                style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0,40,0,40),
              color: const Color(0xFF051752),
              child: Center( 
                child: Container(
                  height: 260, // 1/5 of the screen width
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Fond',
                          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 36, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 100),
                      SizedBox(
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(                      
                              onPressed: () {
                                // Handle Les mer
                              },
                              child: const Text(
                                'Les mer',
                                style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0,40,0,40),
              child: Center( 
                child: Container(
                  height: 260, // 1/5 of the screen width
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Kompendier',
                          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 36, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 100),
                      SizedBox(
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(                      
                              onPressed: () {
                                // Handle Les mer
                              },
                              child: const Text(
                                'Les mer',
                                style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
  
}