import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EndDrawerHeader extends StatelessWidget {
  const EndDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Center(
        child: Text(
          "Menu",
          style: GoogleFonts.raleway(
            color: const Color(0xff327B90),
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
