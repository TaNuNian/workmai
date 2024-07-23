import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/main_pages/profile_pages/user_profile.dart';

class MatchResultTile extends StatelessWidget {
  final Color color;
  final String displayname;
  final String? profilePicture;
  final String username;
  final String? stars;
  final String uid;
  final String? mode;
  final bool alreadyMatch;

  const MatchResultTile({
    super.key,
    required this.color,
    required this.displayname,
    this.profilePicture,
    required this.username,
    this.stars,
    required this.uid,
    this.mode,
    required this.alreadyMatch,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: fix about mode
        print('mode: $mode');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfile(
              uid: uid,
              actionType: alreadyMatch ? 2:1,
            ),
          ),
        );
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
              (profilePicture != null && profilePicture!.isNotEmpty)
                  ? NetworkImage(profilePicture!)
                  : null,
              backgroundColor:
              (profilePicture != null && profilePicture!.isNotEmpty)
                  ? Colors.transparent
                  : const Color(0xffD9D9D9),
              child: (profilePicture == null || profilePicture!.isEmpty)
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
                if (stars != null)
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
                              stars!,
                              style: GoogleFonts.inter(
                                color: color,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
