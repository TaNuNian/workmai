import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';

class ContinueButton extends StatefulWidget {
  const ContinueButton({super.key});

  @override
  _ContinueButtonState createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.4,
        height: MediaQuery.sizeOf(context).height * 0.06,
        decoration: BoxDecoration(
          gradient: crossLinearGradient,
          borderRadius: BorderRadius.circular(
              (MediaQuery.sizeOf(context).height * 0.06) / 2),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            // Removes default button background color
            shadowColor: Colors.transparent,
            // Removes shadow
          ),
          child: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(
              maxWidth: double.infinity, // Stretches button to full width
              minHeight: 50.0, // Sets minimum height for the button
            ),
            child: Text(
              'Continue',
              style: GoogleFonts.sarabun(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ),
        ),
      ),
    );
  }
}
