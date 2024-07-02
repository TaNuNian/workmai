import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendList extends StatelessWidget {
  final Color color;
  final String displayname;
  final String username;
  final String? profilePicture;
  final VoidCallback onTap;

  const FriendList({
    super.key,
    required this.color,
    required this.displayname,
    required this.username,
    required this.profilePicture,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(52.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  profilePicture != null ? NetworkImage(profilePicture!) : null,
              child: profilePicture == null
                  ? const Icon(Icons.person, size: 30)
                  : null,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayname,
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(username,
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
