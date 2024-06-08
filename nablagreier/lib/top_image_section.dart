// top_image_section.dart
import 'package:flutter/material.dart';

class TopImageSection extends StatelessWidget {
  const TopImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.width * 1 / 3, // 1/3 of the screen width
        decoration: const BoxDecoration(
          color: Color(0xFF061025), // Background color of the top part
          image: DecorationImage(
            image: AssetImage('images/nablabakgrunn.jpg'), // Background image
            fit: BoxFit.cover,
            opacity: 0.7,
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
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(MediaQuery.of(context).size.width / 20, MediaQuery.of(context).size.width / 30),
                            ),
                            side: MaterialStateProperty.all<BorderSide>(
                              const BorderSide(color: Color(0xF0FFFFFF), width: 2.0),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF1045A6),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0x40FFFFFF),
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/register'); // Navigate to the register page
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
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(MediaQuery.of(context).size.width / 20, MediaQuery.of(context).size.width / 30),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFDBEEFF),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF1045A6),
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login'); // Navigate to the login page
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
