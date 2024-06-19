import 'package:flutter/material.dart';
import 'package:workmai/src/main_pages/profile_pages/my_profile_wg/inter_tag.dart';
import 'package:workmai/src/main_pages/profile_pages/my_profile_wg/myprofile_appear.dart';

import 'package:workmai/src/decor/divider.dart';
import 'package:workmai/src/main_pages/profile_pages/my_profile_wg/skill_tag.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyProfileAppear(),
              CustomDivider(),
              InterTag(),
              SkillTag(),
              CustomDivider(),
              // AboutMe(),
            ],
          ),
        )
      ),
    );
  }
}
