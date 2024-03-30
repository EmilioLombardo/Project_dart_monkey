//flere_arrangementer.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class FlereArrangementer extends StatelessWidget {
  const FlereArrangementer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context,listen: false);

    return SliverToBoxAdapter(
      child: Center( // Centering the Container to restrict its width.
        child: Container(
          width: MediaQuery.of(context).size.width * 9 / 10,
          padding: EdgeInsets.all(40.0),
          color: themeProvider.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Text(
                      'Arrangementer',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: MediaQuery.of(context).size.width / 40,
                        fontWeight: FontWeight.w700,
                        color: themeProvider.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  /*
                    List over activities
                  */
                  SizedBox(height: MediaQuery.of(context).size.height / 40),

                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Strikk og drikk',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 60,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiBackgroundColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiBackgroundColor,
                          ),
                          textAlign: TextAlign.left,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Programmering og selvservering',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 60,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Påmelding innen 31.03',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiBackgroundColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiBackgroundColor,
                          ),
                          textAlign: TextAlign.left,
                        ),

                      ],
                    ),
                  ),
                ],
                
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Text(
                      'Bedriftspresentasjoner',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: MediaQuery.of(context).size.width / 40,
                        fontWeight: FontWeight.w700,
                        color: themeProvider.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                  ),


                  /*
                    List over bed.press.
                  */
                  SizedBox(height: MediaQuery.of(context).size.height / 40),

                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Consultsultensen',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 60,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Påmelding innen 31.03',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiBackgroundColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiBackgroundColor,
                          ),
                          textAlign: TextAlign.left,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Conconsulticoncon',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 60,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Påmelding innen 31.03',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiBackgroundColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiBackgroundColor,
                          ),
                          textAlign: TextAlign.left,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sulticonsultsultcon',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 60,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Påmelding innen 31.03',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiBackgroundColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.antiBackgroundColor,
                          ),
                          textAlign: TextAlign.left,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
