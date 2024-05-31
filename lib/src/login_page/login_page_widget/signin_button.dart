import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../decor/gradients.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'ลงชื่อเข้าใช้',
            style: GoogleFonts.sarabun(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
          ),
        ),
      ),
    );
  }
}
