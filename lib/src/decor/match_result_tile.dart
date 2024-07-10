import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchResultTile extends StatelessWidget {
  final Color color;
  final String displayname;
  final String? profilePicture;
  final String username;
  final String stars;

  const MatchResultTile({
    super.key,
    required this.color,
    required this.displayname,
    this.profilePicture,
    required this.username,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '');
      },
      onLongPress: () {
        return;
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  displayname,
                  style: GoogleFonts.raleway(
                    color: const Color(0xffffffff),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: color,
                            size: 16,
                          ),
                          Text(
                            stars,
                            style: GoogleFonts.inter(
                                color: color,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            subtitle: Text(
              username,
              // TODO: Make it 'You: ...' or '$DISPLAYNAME: ...'
            ),
            subtitleTextStyle: GoogleFonts.raleway(
              color: const Color(0xffFFFFFF),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}