import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/inter_tag.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/skill_tag.dart';

class BbgenGroupChatSetting extends StatelessWidget {
  final String groupName;
  final String groupProfilePicture;

  BbgenGroupChatSetting({super.key, required this.groupName, required this.groupProfilePicture});

  final List<String> skilledTags = [];
  final List<String> interestedTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _body(context),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        groupName,
        style: GoogleFonts.raleway(
          color: const Color(0xff327B90),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xffEFFED5),
    );
  }

  _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // Group Profile
          Container(
            color: const Color(0xffEFFED5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _groupProfile(context),
                InterTag(interestedTags: interestedTags),
                SkillTag(skilledTags: skilledTags)
              ],
            ),
          ),

          //
          const SizedBox(height: 16),
          Container(
            color: const Color(0xffEFFED5),
            child: _chatSettingMenu(context),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'LEAVE GROUP',
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: groupProfilePicture.isNotEmpty ? NetworkImage(groupProfilePicture) : null,
            backgroundColor: Colors.lightBlueAccent,
            child: groupProfilePicture.isEmpty ? const Icon(Icons.group, size: 40) : null,
          ),
          const SizedBox(width: 16),
          Text(
            groupName,
            style: GoogleFonts.raleway(
              color: const Color(0xff327B90),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _chatSettingMenu(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.01,
        horizontal: MediaQuery.sizeOf(context).width * 0.02,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: GoogleFonts.raleway(
                    color: const Color(0xff327B90),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xffA6EDD1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}
