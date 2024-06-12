//sticky_header.dart
import 'package:flutter/material.dart';
import 'package:nablagreier/app_colors.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final isSystemDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final iconData = (themeProvider.themeMode == ThemeMode.system ? isSystemDarkMode : themeProvider.isDarkMode) ? Icons.light_mode : Icons.dark_mode;

    return SliverToBoxAdapter(
      child: Container(
        color: WebColors.nablaBlue,
        width: MediaQuery.of(context).size.width,
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kontakt oss",
                  style: TextStyle(
                    fontSize: 32, 
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w400,
                    color: WebColors.darkTextColor, 
                  ),
                ),
                Text(
                  "Linjeforeningen Nabla",
                  style: TextStyle(
                    fontSize: 14, 
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    color: WebColors.darkTextColor, 
                  ),
                ),
                Text(
                  "Kjemiblokk 2, Realfagbygget",
                  style: TextStyle(
                    fontSize: 14, 
                    fontFamily: 'Calito',
                    fontWeight: FontWeight.w400,
                    color: WebColors.darkTextColor, 
                  ),
                ),
                Text(
                  "Sæm Sælands vei 10, NTNU",
                  style: TextStyle(
                    fontSize: 14, 
                    fontFamily: 'Calito',
                    fontWeight: FontWeight.w400,
                    color: WebColors.darkTextColor, 
                  ),
                ),
                Text(
                  "7034 Trondheim",
                  style: TextStyle(
                    fontSize: 14, 
                    fontFamily: 'Calito',
                    fontWeight: FontWeight.w400,
                    color: WebColors.darkTextColor, 
                  ),
                ),

                
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kontakt oss",
                  style: TextStyle(
                    fontSize: 32, 
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    color: WebColors.darkTextColor, 
                  ),
                ),
                Text(
                  "Linjeforeningen Nabla",
                  style: TextStyle(
                    fontSize: 14, 
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    color: WebColors.darkTextColor, 
                  ),
                ),
                Text(
                  "Kjemiblokk 2, Realfagbygget",
                  style: TextStyle(
                    fontSize: 14, 
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    color: WebColors.darkTextColor, 
                  ),
                ),
                Text(
                  "Sæm Sælands vei 10, NTNU",
                  style: TextStyle(
                    fontSize: 14, 
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    color: WebColors.darkTextColor, 
                  ),
                ),
                Text(
                  "7034 Trondheim",
                  style: TextStyle(
                    fontSize: 14, 
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    color: WebColors.darkTextColor, 
                  ),
                ),

                
              ],
            ),
            Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Text abc",
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Text abc"
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Text abc"
                    ),
                  ),
                ],
              ),
            Column(
              children: const [
                Text(
                  "Newsletter widget", 
                  style: TextStyle(
                    color:Colors.white
                  )
                )
              ],
            )
          ],
        )
      )
    );
  }
}

class _FooterDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _FooterDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_FooterDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
           maxHeight != oldDelegate.maxHeight ||
           child != oldDelegate.child;
  }
}
