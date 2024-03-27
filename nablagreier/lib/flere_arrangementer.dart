import 'package:flutter/material.dart';

class FlereArrangementer extends StatelessWidget {
  const FlereArrangementer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We use MediaQuery to determine the size based on the screen's width.

    return SliverToBoxAdapter(
      child: Center( // Centering the Container to restrict its width.
        child: Container(
          width: MediaQuery.of(context).size.width * 4 / 5,
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
                        color: Colors.white,
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
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
                            color: Color(0xFFDBEEFF),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFDBEEFF),
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
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
                            color: Color(0xFFDBEEFF),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFDBEEFF),
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
                        color: Colors.white,
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
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
                            color: Color(0xFFDBEEFF),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFDBEEFF),
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
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
                            color: Color(0xFFDBEEFF),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFDBEEFF),
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
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 70,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
                            color: Color(0xFFDBEEFF),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: MediaQuery.of(context).size.width / 90,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFDBEEFF),
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
