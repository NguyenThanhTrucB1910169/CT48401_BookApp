import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.ptSerif(
        fontSize: 27, color: Colors.black, fontWeight: FontWeight.w600),
    headline2: GoogleFonts.openSans(
        fontSize: 18, color: Color(0xFF212121), fontWeight: FontWeight.w400),
  );
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: darkTextTheme,
    );
  }
}
