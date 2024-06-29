import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/user_provider.dart';

class MyprofileAppearName extends StatefulWidget {
  final String username;

  const MyprofileAppearName(
      {super.key, required this.username});

  @override
  State<MyprofileAppearName> createState() => _MyprofileAppearNameState();
}

class _MyprofileAppearNameState extends State<MyprofileAppearName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        children: <Widget>[
          _profilePic(context),
          _consumerUsername(context),
        ],
      ),
    );
  }

  _profilePic(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          children: [
            SizedBox(width: 5),
            CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xffD9D9D9),
            ),
          ],
        ),
        _consumerUsername(context),
        const SizedBox(height: 10),
      ],
    );
  }

  _consumerUsername(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Consumer<UserProvider>(
        builder: (context, userProvider, child){
          if (userProvider.userData == null) {
            return Center(child: CircularProgressIndicator());
          }
          final displayName = userProvider.userData!["profile"]["display_name"];
          final userName = userProvider.userData!["profile"]["name"];
          return Padding(

            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName != null && displayName.isNotEmpty ? displayName : 'Display name',
                  style: GoogleFonts.sarabun(
                    color: const Color(0xff327B90),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '@'+userName,
                      style: GoogleFonts.sarabun(
                        color: const Color(0xff59A1B6),
                        fontWeight: FontWeight.w300,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 160,
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(0xffc3e1ea),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Icon(Icons.military_tech),
                            Icon(Icons.star),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
      ],
    );
  }
}
