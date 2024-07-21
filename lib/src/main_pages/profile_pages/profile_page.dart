import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workmai/src/decor/divider.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/aboutme.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/inter_tag.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/profile_appear.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/skill_tag.dart';

class ProfilePage extends StatefulWidget {
  final Widget? button;
  final Map<String, dynamic> userProfile;
  final bool showBackButton;
  final bool? isEdit;

  const ProfilePage({
    super.key,
    this.button,
    required this.userProfile,
    this.showBackButton = false,
    this.isEdit,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late bool isEdit;

  @override
  void initState() {
    super.initState();
    isEdit = widget.isEdit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userProfile);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ProfileAppear(
                            button: widget.button,
                            backgroundPicture:
                            widget.userProfile['backgroundPicture'],
                            name: widget.userProfile['name'],
                            display_name: widget.userProfile['displayName'],
                            profilePicture:
                            widget.userProfile['profilePicture'],
                            isEdit: isEdit,
                          ),
                          const CustomDivider(thickness: 2),
                          InterTag(
                            interestedTags: widget
                                .userProfile['interested_tags']
                                .cast<String>(),
                            isEdit: isEdit,
                          ),
                          SkillTag(
                            skilledTags: widget.userProfile['skilled_tags']
                                .cast<String>(),
                            isEdit: isEdit,
                          ),
                          const CustomDivider(thickness: 1.5),
                          AboutMe(
                            birthdate:
                            (widget.userProfile['birthdate'] as Timestamp)
                                .toDate()
                                .toString()
                                .substring(0, 10),
                            age: widget.userProfile['age'],
                            mbti: widget.userProfile['mbti'],
                            workStyle: widget.userProfile['work_style'],
                            aboutMe: widget.userProfile['aboutme'],
                            isEdit: isEdit,
                          ),
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            ),
            if (widget.showBackButton)
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xff59A1B6).withOpacity(0.6),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
