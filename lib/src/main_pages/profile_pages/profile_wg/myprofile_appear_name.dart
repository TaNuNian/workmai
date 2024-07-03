import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/profile_picker.dart';
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
        Consumer<UploadProfile>(
          builder: (context, uploadProfile, child) {
            bool hasProfilePicture = uploadProfile.userData?['profile']['profilePicture'] != null;
            return Row(
              children: [
                const SizedBox(width: 5),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: hasProfilePicture
                      ? NetworkImage(uploadProfile.userData!['profile']['profilePicture'])
                      : null,
                  backgroundColor: hasProfilePicture ? Colors.transparent : const Color(0xffD9D9D9),
                  child: hasProfilePicture
                      ? null
                      : const Icon(Icons.person, size: 60),
                ),
              ],
            );
          },
        ),
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
            return const Center(child: CircularProgressIndicator());
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
                  style: GoogleFonts.raleway(
                    color: const Color(0xff327B90),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '@'+userName,
                      style: GoogleFonts.raleway(
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
