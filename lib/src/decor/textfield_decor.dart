import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration textfieldSearchDec(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.sarabun(
      color: Colors.black.withOpacity(0.3),
      fontSize: 16,
    ),
    prefixIcon: const Icon(
      Icons.search,
      color: Color(0xffB8E175),
    ),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    disabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),
  );
}

InputDecoration textfieldDec(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.sarabun(
      color: Colors.black.withOpacity(0.3),
      fontSize: 16,
    ),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    disabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),
  );
}

