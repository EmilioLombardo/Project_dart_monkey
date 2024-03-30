//top_image_section.dart
import 'package:flutter/material.dart';
import 'package:nablagreier/app_colors.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; 

class TopImageSection extends StatelessWidget {
  const TopImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.width * 1 / 3, // 1/3 of the screen width
        decoration: const BoxDecoration(
          color: WebColors.darkBackgroundColor, // Background color of the top part
          image: DecorationImage(
            image: AssetImage('images/nablabakgrunn.jpg'), // Background image
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.width * 1 / 10, // Adjust the position based on your needs
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Nabla',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: MediaQuery.of(context).size.width / 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Linjeforeningen for fysikk og matematikk',
                      style: TextStyle(
                        fontFamily: 'Satoshi', // font
                        fontSize: MediaQuery.of(context).size.width / 60,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width / 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          style: OutlinedButton.styleFrom( // Sign up button styling
                            minimumSize: Size(MediaQuery.of(context).size.width / 20, MediaQuery.of(context).size.width / 30),
                            side: BorderSide(color: Color(0xF0FFFFFF), width: 2.0),
                            foregroundColor: Color(0xFF1045A6),
                            backgroundColor: Color(0x40FFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                          ),
                          onPressed: () {
                            // Handle Sign Up
                          },
                          child: const Text(
                            'Registrer deg',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQuery.of(context).size.width / 20, MediaQuery.of(context).size.width / 30),
                            foregroundColor: Color(0xFFDBEEFF),
                            backgroundColor: Color(0xFF1045A6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                          ),
                          onPressed: () {
                            // Handle Sign In
                          },
                          child: const Text(
                            'Logg inn',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
