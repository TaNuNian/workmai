import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendlistPage extends StatelessWidget {
  const FriendlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff327b90),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 24,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'CHAT',
          style: GoogleFonts.sarabun(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
