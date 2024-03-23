import 'package:flutter/material.dart';

class KommendeArrangement extends StatelessWidget {
  const KommendeArrangement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We use MediaQuery to determine the size based on the screen's width.
    final double containerWidth = MediaQuery.of(context).size.width * 2 / 3;    // Two-thirds of the screen width
    final double containerHeight = MediaQuery.of(context).size.height * 1 / 2;  // Half of the screen height
    
    return SliverToBoxAdapter(
      child: Center( // Centering the Container to restrict its width.
        child: Container(
          // We specify the size of the Container directly.
          width: containerWidth,
          height: containerHeight,
          color: Color(0xFF051752), // The desired background color.
          
          child: Padding( // Padding for internal content, adjust as needed.
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the column.
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight, // Align text to the right.
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: Text(
                      'Kommende arrangement',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight, // Align text to the right.
                  child: Container(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
