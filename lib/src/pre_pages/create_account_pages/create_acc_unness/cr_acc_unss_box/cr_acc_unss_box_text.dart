import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CrAccUnssBoxText extends StatelessWidget {
  final String header;
  const CrAccUnssBoxText({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        header,
        style: GoogleFonts.sarabun(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          height: 1.2
        ),
      ),
    );
  }
}
