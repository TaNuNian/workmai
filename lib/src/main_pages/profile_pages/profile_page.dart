import 'package:flutter/material.dart';
import 'package:workmai/src/decor/divider.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/aboutme.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/inter_tag.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/profile_appear.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/skill_tag.dart';

class ProfilePage extends StatefulWidget {
  final Widget button;
  final String uid;

  const ProfilePage({super.key, required this.button, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ProfileAppear(button: widget.button),
                    const CustomDivider(thickness: 2),
                    const InterTag(),
                    const SkillTag(),
                    const CustomDivider(thickness: 1.5),
                    const AboutMe(),
                  ],
                );
              },
              childCount: 1,
            ),
          )
        ],
      )),
    );
  }
}
