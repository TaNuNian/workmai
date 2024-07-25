import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/main_pages/chat_page/bbgen_group_chat_page.dart';

class GroupChatListTile extends StatelessWidget {
  final Color color;
  final String chatId;
  final String groupName;
  final String groupProfilePicture;

  const GroupChatListTile({
    super.key,
    required this.color,
    required this.chatId,
    required this.groupName,
    required this.groupProfilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BbgenGroupChatPage(
              groupName: groupName,
              groupProfilePicture: groupProfilePicture,
              chatId: chatId,
            ),
          ),
        );
      },
      onLongPress: () {
        return;
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
              backgroundImage: groupProfilePicture.isNotEmpty
                  ? NetworkImage(groupProfilePicture)
                  : null,
              child: groupProfilePicture.isEmpty
                  ? const Icon(Icons.group, size: 30)
                  : null,
            ),
            title: Text(
              groupName,
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            titleTextStyle: GoogleFonts.raleway(color: const Color(0xff1E1E1E)),
          ),
        ),
      ),
    );
  }
}
