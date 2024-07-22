import 'package:flutter/material.dart';
import 'package:workmai/methods/cloud_firestore/userservice.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_page.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/myprofile_appear_add.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/myprofile_appear_edit.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/myprofile_appear_match.dart';

class UserProfile extends StatelessWidget {
  final String uid;
  final bool isAddFriends;

  const UserProfile({super.key, required this.uid,required this.isAddFriends});

  @override
  Widget build(BuildContext context) {
    final UserService _userService = UserService();

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _userService.fetchUserProfile(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading profile'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No profile data found'));
          }

          final userProfile = snapshot.data!;
          print(userProfile);
          return Center(
            child: ProfilePage(
              button: isAddFriends ? MyprofileAppearAdd(uid: uid,):MyprofileAppearMatch(uid: uid,),
              userProfile: userProfile,
              showBackButton: true,
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
