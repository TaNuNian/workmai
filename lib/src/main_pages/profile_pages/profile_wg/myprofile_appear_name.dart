import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/profile_picker.dart';
import 'package:workmai/methods/cloud_firestore/rank.dart';
import 'package:workmai/methods/user_provider.dart';
import 'package:workmai/src/decor/colors.dart';

class MyprofileAppearName extends StatefulWidget {
  final String? username;
  final String? displayName;
  final String? profilePicture;
  final bool isEdit;
  const MyprofileAppearName({
    super.key,
    required this.username,
    required this.displayName,
    required this.profilePicture,
    required this.isEdit,
  });

  @override
  State<MyprofileAppearName> createState() => _MyprofileAppearNameState();
}

class _MyprofileAppearNameState extends State<MyprofileAppearName> {
  final User? user = FirebaseAuth.instance.currentUser;
  final RankService _rankService = RankService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        children: <Widget>[
          _profilePic(context),
          if (user != null) _consumerUsername(context, user!.uid),
          if (user == null) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _profilePic(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<UploadProfile>(
          builder: (context, uploadProfile, child) {
            return Row(
              children: [
                const SizedBox(width: 5),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: widget.profilePicture != null
                      ? NetworkImage(widget.profilePicture!)
                      : null,
                  backgroundColor: widget.profilePicture != null
                      ? Colors.transparent
                      : const Color(0xffD9D9D9),
                  child: widget.profilePicture != null
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

  Widget _consumerUsername(BuildContext context, String uid) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.userData == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final displayName = widget.displayName ?? 'Display name';
            final userName = widget.username ?? 'Username';

            return FutureBuilder<DocumentSnapshot>(
              future: _rankService.getUserRank(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return _buildProfileInfo(displayName, userName, 'Unranked', Colors.grey);
                }

                final rankData = snapshot.data!.data() as Map<String, dynamic>;
                final userRank = rankData['rankName'] ?? 'Unranked';

                return _buildProfileInfo(displayName, userName, getRankName(userRank), getRankColor(userRank));
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildProfileInfo(String displayName, String userName, String rankName, Color rankColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayName,
            style: GoogleFonts.raleway(
              color: const Color(0xff327B90),
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          Row(
            children: [
              Text(
                '@$userName',
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.military_tech,
                        color: rankColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        rankName,
                        style: GoogleFonts.raleway(
                          color: rankColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _editDisplay(BuildContext context, bool isEdit) {
    if (isEdit) {
      return Container(
        height: 40,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: Color(0xff327B90),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_rounded,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      );
    } else {
      return const Text('');
    }
  }
}
