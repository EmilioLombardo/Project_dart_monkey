//kommende_arrangement.dart
import 'package:flutter/material.dart';
import 'package:nablagreier/app_colors.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; 


class KommendeArrangement extends StatelessWidget {
  const KommendeArrangement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context,listen: false);

    return SliverToBoxAdapter(
      child: Center( // Centering the Container to restrict its width.
        child: Container(
          width: MediaQuery.of(context).size.width * 4 / 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width * 7 / 15,
                height: MediaQuery.of(context).size.width * 4 / 15,
                decoration: const BoxDecoration(
                  color: WebColors.darkBackgroundColor,
                  image: DecorationImage(
                    image: AssetImage('images/PlaceHolder.jpg'), 
                    fit: BoxFit.cover,
                    opacity: 1.0,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1 / 3,
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: Text(
                        'Neste arrangement',
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
                              side: BorderSide(color: WebColors.darkTextColor.withOpacity(0.0), width: 0.0),
                              foregroundColor: WebColors.nablaBlue,
                              backgroundColor: WebColors.darkTextColor.withOpacity(0.0), 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.0),
                              ),
                            ),
                            onPressed: () {
                              // Handle Sign Up
                            },
                            child: Text(
                              'Les mer',
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
                              foregroundColor: WebColors.lightBackgroundColor,
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
                                color: WebColors.darkTextColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
