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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/aigen-chat');
      },
      onLongPress: () {
        return ;
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage:
                  profilePicture != null ? NetworkImage(profilePicture!) : null,
              child: profilePicture == null
                  ? const Icon(Icons.person, size: 30)
                  : null, // TODO: CHANGE TO USER PROFILE IMAGE
            ),
            title: Text(
              displayname,
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            titleTextStyle: GoogleFonts.raleway(color: const Color(0xff1E1E1E)),

            subtitle: Text(
              'Self or User: $recentMsg',
              // TODO: Make it 'You: ...' or '$DISPLAYNAME: ...'
            ),
            subtitleTextStyle: GoogleFonts.raleway(
              color: const Color(0xff1E1E1E),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
