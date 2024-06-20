import 'package:flutter/material.dart';
import 'package:workmai/src/main_pages/profile_pages/my_profile_wg/myprofile_appear_edit.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_page.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ProfilePage(button: MyprofileAppearEdit(),),
    );
  }
}
