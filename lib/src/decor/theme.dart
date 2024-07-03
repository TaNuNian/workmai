import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xff67b4ca),
  hintColor: Colors.lightGreenAccent,
  useMaterial3: true,

  splashFactory: NoSplash.splashFactory,

  textTheme: TextTheme(
    displayLarge: GoogleFonts.raleway(fontSize: 72.0, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.raleway(fontSize: 60.0, fontWeight: FontWeight.bold),
    displaySmall: GoogleFonts.raleway(fontSize: 48.0, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.raleway(fontSize: 34.0, fontWeight: FontWeight.bold),
    headlineSmall: GoogleFonts.raleway(fontSize: 24.0, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.raleway(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: GoogleFonts.raleway(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleSmall: GoogleFonts.raleway(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black54),
    bodyLarge: GoogleFonts.raleway(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: GoogleFonts.raleway(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black54),
    bodySmall: GoogleFonts.raleway(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black54),
    labelSmall: GoogleFonts.raleway(fontSize: 10.0, fontWeight: FontWeight.normal, color: Colors.black54),
  ),
);

TextStyle appBarTitleStyle(Color color) {
  return GoogleFonts.raleway(
    color: color,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
}
