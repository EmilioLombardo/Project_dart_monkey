import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'sticky_header.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // Variables to store content from markdown files
  String styretContent = 'Laster...';
  String undergrupperContent = 'Laster...';
  String kompendierContent = 'Laster...';
  String fondContent = 'Laster...';
  String loverContent = 'Laster...';
  String tillitsvalgteContent = 'Laster...';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _preloadMarkdownContent();
  }

  Future<void> _preloadMarkdownContent() async {
    // Load all the markdown files concurrently
    final List<String> content = await Future.wait([
      rootBundle.loadString('assets/tekstbokser/omNabla/styret.md'),
      rootBundle.loadString('assets/tekstbokser/omNabla/undergrupper.md'),
      rootBundle.loadString('assets/tekstbokser/omNabla/tillitsvalgte.md'),
      rootBundle.loadString('assets/tekstbokser/omNabla/lover.md'),
      rootBundle.loadString('assets/tekstbokser/omNabla/fond.md'),
      rootBundle.loadString('assets/tekstbokser/omNabla/kompendier.md'),
    ]);

    // Update the state with the loaded content
    setState(() {
      styretContent = content[0];
      undergrupperContent = content[1];
      tillitsvalgteContent = content[2];
      loverContent = content[3];
      fondContent = content[4];
      kompendierContent = content[5];
      isLoading = false; // All content is loaded
    });
  }
  MarkdownStyleSheet _buildMarkdownStyleSheet() {
    return MarkdownStyleSheet(
      p: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          StickyHeader(),

          //Styret
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 100),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Hva er Nabla?',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          color: Colors.white),
                    ),
                    Text(
                      'Nabla er linjeforeningen for sivilingeniørprogrammet Fysikk og matematikk ved NTNU.',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Styret Section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              color: const Color(0xFF041262),
              child: Center(
                child: Container(
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Styret',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 36,
                              color: Color(0xFF6E90DD)),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 480,
                        child: styretContent.isNotEmpty
                            ? MarkdownBody(data: styretContent, styleSheet: _buildMarkdownStyleSheet())
                            : CircularProgressIndicator(), // Show a loader while content is loading
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: 480,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                // Handle Les mer
                              },
                              child: const Text(
                                'Les mer om styrestillingene',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Undergrupper Section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              child: Center(
                child: Container(
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 480,
                        child: Text(
                          'Undergrupper',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 36,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 480,
                        child: undergrupperContent.isNotEmpty
                            ? MarkdownBody(data: undergrupperContent, styleSheet: _buildMarkdownStyleSheet())
                            : CircularProgressIndicator(),
                      ),
                      SizedBox(height: 50),
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
                                'Les mer om undergruppene',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Tillitsvalgte Section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              color: const Color(0xFF615200),
              child: Center(
                child: Container(
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Tillitsvalgte',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 36,
                              color: Color(0xFFF0C433)),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: tillitsvalgteContent.isNotEmpty
                            ? MarkdownBody(data: tillitsvalgteContent, styleSheet: _buildMarkdownStyleSheet())
                            : CircularProgressIndicator(),
                      ),
                      SizedBox(height: 50),
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
                                'Les mer om de ulike tillitsvalgtrollene',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

           // Lover og forskrifter Section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              child: Center(
                child: Container(
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 480,
                        child: Text(
                          'Lover og forskrifter',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 36,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 480,
                        child: loverContent.isNotEmpty
                            ? MarkdownBody(data: loverContent, styleSheet: _buildMarkdownStyleSheet())
                            : CircularProgressIndicator(),
                      ),
                      SizedBox(height: 50),
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
                                'Les mer om lovene og forskriftene',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Fond Section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              color: const Color(0xFF046225),
              child: Center(
                child: Container(
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Fond',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 36,
                              color: Color(0xFF6EDDA6)),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: fondContent.isNotEmpty
                            ? MarkdownBody(data: fondContent, styleSheet: _buildMarkdownStyleSheet())
                            : CircularProgressIndicator(),
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
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Kompendier Section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              child: Center(
                child: Container(
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        child: Text(
                          'Kompendier',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 36,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: kompendierContent.isNotEmpty
                            ? MarkdownBody(data: kompendierContent, styleSheet: _buildMarkdownStyleSheet())
                            : CircularProgressIndicator(),
                      ),
                      SizedBox(height: 50),
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
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
