import 'package:flutter/material.dart';

class FlereArrangementer extends StatelessWidget {
  const FlereArrangementer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          width: 1024,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 480,
                    child: Text(
                      'Arrangementer',
                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 32, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  /*
                    List over activities
                  */
                  SizedBox(height: 24),

                  Container(
                    width: 480,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Strikk og drikk',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 480,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFDBEEFF)),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFDBEEFF)),
                          textAlign: TextAlign.left,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: 480,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Programmering og selvservering',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 480,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Påmelding innen 31.03',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFDBEEFF)),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFDBEEFF)),
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
                    width: 480,
                    child: Text(
                      'Bedriftspresentasjoner',
                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 32, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    
                  ),


                  /*
                    List over bed.press.
                  */
                  SizedBox(height: 24),

                  Container(
                    width: 480,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Consultsultensen',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 480,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Påmelding innen 31.03',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFDBEEFF)),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFDBEEFF)),
                          textAlign: TextAlign.left,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: 480,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Conconsulticoncon',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 480,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Påmelding innen 31.03',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFDBEEFF)),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFDBEEFF)),
                          textAlign: TextAlign.left,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: 480,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sulticonsultsultcon',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '01. april',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 480,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Påmelding innen 31.03',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFDBEEFF)),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '0/40',
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400 ,fontSize: 16, color: Color(0xFFDBEEFF)),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
