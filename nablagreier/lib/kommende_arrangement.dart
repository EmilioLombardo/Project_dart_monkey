import 'package:flutter/material.dart';

class KommendeArrangement extends StatelessWidget {
  const KommendeArrangement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We use MediaQuery to determine the size based on the screen's width.

    return SliverToBoxAdapter(
      child: Center( // Centering the Container to restrict its width.
        child: Container(
          height: MediaQuery.of(context).size.width * 1 / 5, // 1/3 of the screen width
          width: MediaQuery.of(context).size.width * 4 / 5,
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text(
                  'Neste arrangement',
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: MediaQuery.of(context).size.width / 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  style: TextStyle(
                    fontFamily: 'Carlito',
                    fontSize: MediaQuery.of(context).size.width / 80,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 15),
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                child: Row(
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
                        'Les mer',
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
                        'Påmelding',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
