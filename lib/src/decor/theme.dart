import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xff67b4ca),
  hintColor: Colors.lightGreenAccent,
  useMaterial3: true,

  textTheme: TextTheme(
    displayLarge: GoogleFonts.sarabun(fontSize: 72.0, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.sarabun(fontSize: 60.0, fontWeight: FontWeight.bold),
    displaySmall: GoogleFonts.sarabun(fontSize: 48.0, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.sarabun(fontSize: 34.0, fontWeight: FontWeight.bold),
    headlineSmall: GoogleFonts.sarabun(fontSize: 24.0, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.sarabun(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: GoogleFonts.sarabun(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleSmall: GoogleFonts.sarabun(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black54),
    bodyLarge: GoogleFonts.sarabun(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: GoogleFonts.sarabun(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black54),
    bodySmall: GoogleFonts.sarabun(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black54),
    labelSmall: GoogleFonts.sarabun(fontSize: 10.0, fontWeight: FontWeight.normal, color: Colors.black54),
  ),
);

TextStyle appBarTitleStyle(Color color) {
  return GoogleFonts.sarabun(
    color: color,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
}
