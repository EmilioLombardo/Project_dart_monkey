import 'package:flutter/material.dart';

class NablaColor{
  static var nablaBlue = const Color(0xFF1045A6);
  static var nablaBlueDark = const Color(0xFF083A95);
  static var nablaBlueLight = const Color(0xFF2366E1);
  static var nablaGold = const Color(0xFFFEC84B);

  static var white = Colors.white;
  static var black = Colors.black;

  static var b = false; //themeprovider here, lightmode true, darkmode false
  static var primaryBackgroundColor = b? const Color(0xFFFFFFFF) : const Color(0xFF061025);
  static var secondaryBackgroundColor = b? const Color(0xFFDBEEFF) : const Color(0xFF062179);
  
  static var primaryTextColor = b? const Color(0xFF061025) : const Color(0xFFFFFFFF);
  static var secondaryTextColor = b? const Color(0xFF062179) : const Color(0xFFDBEEFF);

  static var highlightBlue = b? const Color(0xFF0BA5EC) : const Color(0xFF0086C9);
  static var highlightYellow = b? const Color(0xFFFDB022) : const Color(0xFFF79009);
  static var highlightPink = b? const Color(0xFFEE46BC) : const Color(0xFFDD2590);

  static var success = b? const Color(0xFF12B76A) : const Color(0xFF039855);
  static var warning = b? const Color(0xFFF79009) : const Color(0xFFDC6803);
  static var error = b? const Color(0xFFF04438) : const Color(0xFFD92D20);

  //Blues - Primary
  static var blue_025 = const Color(0xFFFAFBFF);
  static var blue_050 = const Color(0xFFEBF1FF);
  static var blue_100 = const Color(0xFFCCDDFF);
  static var blue_200 = const Color(0xFFB2CBFB);
  static var blue_300 = const Color(0xFF80AAF6);
  static var blue_400 = const Color(0xFF5085E7);
  static var blue_500 = const Color(0xFF2366E1);
  static var blue_600 = const Color(0xFF0C4FCB);
  static var blue_700 = const Color(0xFF1045A6);
  static var blue_800 = const Color(0xFF083A95);
  static var blue_900 = const Color(0xFF0E2C6C);
  static var blue_950 = const Color(0xFF0D1E51);

  //Golds - Secondary
  static var gold_025 = const Color(0xFFFFFCF5);
  static var gold_050 = const Color(0xFFFFFAEB);
  static var gold_100 = const Color(0xFFFEF0C7);
  static var gold_200 = const Color(0xFFFEDF89);
  static var gold_300 = const Color(0xFFFEC84B);
  static var gold_400 = const Color(0xFFFDB022);
  static var gold_500 = const Color(0xFFF79009);
  static var gold_600 = const Color(0xFFDC6803);
  static var gold_700 = const Color(0xFFB54708);
  static var gold_800 = const Color(0xFF93370D);
  static var gold_900 = const Color(0xFF7A2E0E);
  static var gold_950 = const Color(0xFF4E1D09);

  //Greys - Support
  static var grey_025 = const Color(0xFFFCFCFD);
  static var grey_050 = const Color(0xFFF9FAFB);
  static var grey_100 = const Color(0xFFF2F4F7);
  static var grey_200 = const Color(0xFFE4E7EC);
  static var grey_300 = const Color(0xFFD0D5DD);
  static var grey_400 = const Color(0xFF98A2B3);
  static var grey_500 = const Color(0xFF667085);
  static var grey_600 = const Color(0xFF475467);
  static var grey_700 = const Color(0xFF344054);
  static var grey_800 = const Color(0xFF1D2939);
  static var grey_900 = const Color(0xFF101828);
  static var grey_950 = const Color(0xFF0C111D);


  //Highlight blue - highlight
  static var highlightBlue_025 = const Color(0xFFF5FBFF);
  static var highlightBlue_050 = const Color(0xFFF0F9FF);
  static var highlightBlue_100 = const Color(0xFFE0F2FE);
  static var highlightBlue_200 = const Color(0xFFB9E6FE);
  static var highlightBlue_300 = const Color(0xFF7CD4FD);
  static var highlightBlue_400 = const Color(0xFF36BFFA);
  static var highlightBlue_500 = const Color(0xFF0BA5EC);
  static var highlightBlue_600 = const Color(0xFF0086C9);
  static var highlightBlue_700 = const Color(0xFF026AA2);
  static var highlightBlue_800 = const Color(0xFF065986);
  static var highlightBlue_900 = const Color(0xFF0B4A6F);
  static var highlightBlue_950 = const Color(0xFF062C41);


  //Highlight pink - highlight
  static var highlightPink_025 = const Color(0xFFFEF6FB);
  static var highlightPink_050 = const Color(0xFFFDF2FA);
  static var highlightPink_100 = const Color(0xFFFCE7F6);
  static var highlightPink_200 = const Color(0xFFFCCEEE);
  static var highlightPink_300 = const Color(0xFFFAA7E0);
  static var highlightPink_400 = const Color(0xFFF670C7);
  static var highlightPink_500 = const Color(0xFFEE46BC);
  static var highlightPink_600 = const Color(0xFFDD2590);
  static var highlightPink_700 = const Color(0xFFC11574);
  static var highlightPink_800 = const Color(0xFF9E165F);
  static var highlightPink_900 = const Color(0xFF851651);
  static var highlightPink_950 = const Color(0xFF4E0D30);

  //Highlight yellow - highlight <- same as warning and secondary
  static var highlightYellow_025 = const Color(0xFFFFFCF5);
  static var highlightYellow_050 = const Color(0xFFFFFAEB);
  static var highlightYellow_100 = const Color(0xFFFEF0C7);
  static var highlightYellow_200 = const Color(0xFFFEDF89);
  static var highlightYellow_300 = const Color(0xFFFEC84B);
  static var highlightYellow_400 = const Color(0xFFFDB022);
  static var highlightYellow_500 = const Color(0xFFF79009);
  static var highlightYellow_600 = const Color(0xFFDC6803);
  static var highlightYellow_700 = const Color(0xFFB54708);
  static var highlightYellow_800 = const Color(0xFF93370D);
  static var highlightYellow_900 = const Color(0xFF7A2E0E);
  static var highlightYellow_950 = const Color(0xFF4E1D09);
  
  //Green - success
  static var success_025 = const Color(0xFFF6FEF9);
  static var success_050 = const Color(0xFFECFDF3);
  static var success_100 = const Color(0xFFD1FADF);
  static var success_200 = const Color(0xFFA6F4C5);
  static var success_300 = const Color(0xFF6CE9A6);
  static var success_400 = const Color(0xFF32D583);
  static var success_500 = const Color(0xFF12B76A);
  static var success_600 = const Color(0xFF039855);
  static var success_700 = const Color(0xFF027A48);
  static var success_800 = const Color(0xFF05603A);
  static var success_900 = const Color(0xFF054F31);
  static var success_950 = const Color(0xFF053321);

  //Yellow - warning
  static var warning_025 = const Color(0xFFFFFCF5);
  static var warning_050 = const Color(0xFFFFFAEB);
  static var warning_100 = const Color(0xFFFEF0C7);
  static var warning_200 = const Color(0xFFFEDF89);
  static var warning_300 = const Color(0xFFFEC84B);
  static var warning_400 = const Color(0xFFFDB022);
  static var warning_500 = const Color(0xFFF79009);
  static var warning_600 = const Color(0xFFDC6803);
  static var warning_700 = const Color(0xFFB54708);
  static var warning_800 = const Color(0xFF93370D);
  static var warning_900 = const Color(0xFF7A2E0E);
  static var warning_950 = const Color(0xFF4E1D09);
  
  //Red - error
  static var error_025 = const Color(0xFFFFFBFA);
  static var error_050 = const Color(0xFFFEF3F2);
  static var error_100 = const Color(0xFFFEE4E2);
  static var error_200 = const Color(0xFFFECDCA);
  static var error_300 = const Color(0xFFFDA29B);
  static var error_400 = const Color(0xFFF97066);
  static var error_500 = const Color(0xFFF04438);
  static var error_600 = const Color(0xFFD92D20);
  static var error_700 = const Color(0xFFB42318);
  static var error_800 = const Color(0xFF912018);
  static var error_900 = const Color(0xFF7A271A);
  static var error_950 = const Color(0xFF55160C);

}

class NablaText {
  //Headers
  static primaryHeader(Color c){return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 44, color: c);}
  static secondaryHeader(Color c){return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 32, color: c);}
  static subHeader(Color c){return TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400, fontSize: 24, color: c);}
  static headerHeader(Color c){return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 18, color: c);}
  static smallHeader(Color c){return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 18, color: c);}
  static tinyHeader(Color c){return TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14, color: c);}
  
  //Texts
  static plainText(Color c){return TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 18, color: c);}
  static plainTextwithSize(Color c, double n){return TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: n, color: c);}
  static boldText(Color c){return TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w700, fontSize: 18, color: c);}
  static italicText(Color c){return TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 18, fontStyle: FontStyle.italic, color: c);}
  static linkText(Color c){return TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w700, fontSize: 18, decoration: TextDecoration.underline, decorationColor: c, color: c);}
  
}

class NablaButtons {
  static primaryButton(Color c1, Color c2){return ButtonStyle(backgroundColor: WidgetStateProperty.all(c1), overlayColor: WidgetStateProperty.all(c2), padding: WidgetStateProperty.all(EdgeInsets.all(14)), shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),);}

}