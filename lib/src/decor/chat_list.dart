import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatList extends StatelessWidget {
  final Color color;
  final String displayname;
  final String recentMsg;

  const ChatList({
    super.key,
    required this.color,
    required this.displayname,
    required this.recentMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      color: const Color(0x95ffffff),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xff9f9f9f),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              displayname,
              style: GoogleFonts.raleway(
                color: const Color(0xff59A1B6),
              ),
            ),
          ],
        ),
        titleTextStyle: GoogleFonts.sarabun(color: Colors.black87),
      ),
    );
  }
}
