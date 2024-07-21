import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchingLoadingPage extends StatelessWidget {
  const MatchingLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Match Running...',
              style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
