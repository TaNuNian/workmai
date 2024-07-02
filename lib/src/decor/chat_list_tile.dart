import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListTile extends StatelessWidget {
  final Color color;
  final String displayname;
  final String? profilePicture;
  final String recentMsg;

  const ChatListTile({
    super.key,
    required this.color,
    required this.displayname,
    this.profilePicture,
    required this.recentMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0x95ffffff),
        borderRadius: BorderRadius.circular(32),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage:
              profilePicture != null ? NetworkImage(profilePicture!) : null,
          child: profilePicture == null
              ? const Icon(Icons.person, size: 30)
              : null,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              displayname,
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Self or User: $recentMsg',
              // TODO: Make it 'You: ...' or '$DISPLAYNAME: ...'
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        titleTextStyle: GoogleFonts.sarabun(color: Colors.black87),
      ),
    );
  }
}
