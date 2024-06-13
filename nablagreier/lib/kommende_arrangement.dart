// kommende_arrangement.dart
import 'package:flutter/material.dart';

class KommendeArrangement extends StatelessWidget {
  const KommendeArrangement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We use MediaQuery to determine the size based on the screen's width.

    return SliverToBoxAdapter(
      child: Center( // Centering the Container to restrict its width.
        child: Container(
          height: 260, // 1/5 of the screen width
          width: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 400,
                child: Text(
                  'Neste arrangement',
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 36, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 400,
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 100),
              Container(
                width: 400,
                child: Row(
                  children: <Widget>[
                    OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: Color(0x00FFFFFF), width: 2.0),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFDBEEFF),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0x00000000),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Handle Sign Up
                      },
                      child: const Text(
                        'Les mer',
                        style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFFFFFFF)),
                      ),
                    ),
                    SizedBox(width: 60),
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFDBEEFF),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF1045A6),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Handle Sign In
                      },
                      child: const Text(
                        'Påmelding',
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
    );
  }
}