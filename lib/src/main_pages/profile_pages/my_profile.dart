import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workmai/methods/cloud_firestore/userservice.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_page.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/myprofile_appear_edit.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    if (user == null) {
      return Scaffold(
        body: Center(child: Text('No user signed in')),
      );
    }
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _userService.fetchUserProfile(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading profile'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No profile data found'));
          }

          final userProfile = snapshot.data!;
          return ProfilePage(
            button: MyprofileAppearEdit(),
            userProfile: userProfile,
          );
        },
      ),
    );
  }
}