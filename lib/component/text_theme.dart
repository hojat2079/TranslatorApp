import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextTheme {
  TextStyle get subHeading1Style {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color:  Colors.grey));
  }

  TextStyle get heading4Style {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color:  Colors.black,
    ));
  }

  TextStyle get heading6Style {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color:  Colors.black,
    ));
  }

  TextStyle get body1Style {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color:  Colors.black,
    ));
  }

  TextStyle get body2Style {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color:Colors.black,
    ));
  }
}
