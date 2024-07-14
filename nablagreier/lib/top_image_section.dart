import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopImageSection extends StatelessWidget {
  const TopImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SliverToBoxAdapter(
      child: Container(
        height: 420, // 1/3 of the screen width
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
              top: 100, // Adjust the position based on your needs
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Nabla',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 56,
                          color: Colors.white),
                    ),
                    Text(
                      'Linjeforeningen for fysikk og matematikk',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                    SizedBox(height: 40),
                    if (user == null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                    color: Color(0xFFFFFFFF), width: 2.0),
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFDBEEFF),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0x00000000),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(18)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/register'); // Navigate to the register page
                            },
                            child: const Text(
                              'Registrer deg',
                              style: TextStyle(
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 3.0,
                                      color: Color(0xFF061025),
                                    ),
                                  ],
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color(0xFFFFFFFF)),
                            ),
                          ),
                          SizedBox(width: 40),
                          ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFDBEEFF),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF1045A6),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(18)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login'); // Navigate to the login page
                            },
                            child: const Text(
                              'Logg inn',
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color(0xFFFFFFFF)),
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
