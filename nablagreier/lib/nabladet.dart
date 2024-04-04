//kommende_arrangement.dart
import 'package:flutter/material.dart';
import 'package:nablagreier/app_colors.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; 


class NyesteNabladet extends StatelessWidget {
  const NyesteNabladet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context,listen: false);

    return SliverToBoxAdapter(
      child: Center( // Centering the Container to restrict its width.
        child: Container(
          height: MediaQuery.of(context).size.width * 1 / 5, // 1/3 of the screen width
          width: MediaQuery.of(context).size.width * 3.5 / 5,
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: Text(
                      'Nyeste Nabladet',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: MediaQuery.of(context).size.width / 40,
                        fontWeight: FontWeight.w700,
                        color: themeProvider.textColor,
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
                        color: themeProvider.textColor,
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
                            side: BorderSide(color: Color(0x00FFFFFF), width: 0.0),
                            foregroundColor: Color(0xFF1045A6),
                            backgroundColor: Color(0x00FFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                          ),
                          onPressed: () {
                            // Handle Sign Up
                          },
                          child: Text(
                            'Flere utgaver',
                            style: TextStyle(
                              color: themeProvider.textColor,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQuery.of(context).size.width / 20, MediaQuery.of(context).size.width / 30),
                            foregroundColor: Color(0xFFDBEEFF),
                            backgroundColor: WebColors.nablaBlue.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                          ),
                          onPressed: () {
                            // Handle Sign In
                          },
                          child: const Text(
                            'Les utgaven',
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
              Container(
                    alignment: Alignment.topRight,
                    width: MediaQuery.of(context).size.width * 1 / 5,
                    height: MediaQuery.of(context).size.width * 2 / 5,
                    decoration: const BoxDecoration(
                      color: WebColors.darkBackgroundColor,
                      image: DecorationImage(
                        image: AssetImage('images/PlaceHolder.jpg'), 
                        fit: BoxFit.cover,
                        opacity: 1.0,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
