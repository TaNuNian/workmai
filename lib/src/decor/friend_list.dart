import 'package:flutter/material.dart';

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
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: profilePicture != null
                  ? NetworkImage(profilePicture!)
                  : null,
              child: profilePicture == null
                  ? Icon(Icons.person, size: 30)
                  : null,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayname,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(username, style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
