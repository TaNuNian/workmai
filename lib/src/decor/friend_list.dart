import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendList extends StatelessWidget {
  final Color color;
  final String displayname;
  final String username;

  const FriendList({
    super.key,
    required this.color,
    required this.displayname,
    required this.username,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(displayname),
            const SizedBox(width: 5),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.45,
              ),
              child: Text('@$username'),
            )
          ],
        ),
        titleTextStyle: GoogleFonts.sarabun(color: Colors.black87),
      ),
    );
  }
}
