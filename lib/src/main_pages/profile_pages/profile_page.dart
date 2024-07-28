import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workmai/src/decor/divider.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/aboutme.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/edit_profile_wg/files_box.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/edit_profile_wg/works_box.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/folio_works.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/inter_tag.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/profile_appear.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/skill_tag.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/social_contact.dart';

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
  late bool isEdit = widget.isEdit ?? false;

  // TODO
  List<Widget> videos = [WorksBox(child: Text('videos'),)];
  List<Widget> files = [FilesBox(child: Text('files'),)];
  List<Widget> links = [Text('link1'), Text('link2'),];


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
                          _profileAppear(context),
                          const CustomDivider(thickness: 1.8),
                          _interTag(context),
                          _skillTag(context),
                          _aboutMe(context),
                          const CustomDivider(thickness: 1.8),
                          _folioWorks(context),
                          const CustomDivider(thickness: 1.8),
                          _socialContact(context),
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            ),
            _isBackButton(context),
          ],
        ),
      ),
    );
  }

  Widget _profileAppear(BuildContext context) {
    return ProfileAppear(
      button: widget.button,
      backgroundPicture: widget.userProfile['backgroundPicture'] ?? '',
      name: widget.userProfile['name'] ?? '',
      display_name: widget.userProfile['displayName'] ?? '',
      profilePicture: widget.userProfile['profilePicture'] ?? '',
      isEdit: isEdit,
    );
  }

  Widget _interTag(BuildContext context) {
    return InterTag(
      interestedTags: (widget.userProfile['interested_tags'] as List<dynamic>?)
          ?.cast<String>() ??
          [],
      isEdit: isEdit,
    );
  }

  Widget _skillTag(BuildContext context) {
    return SkillTag(
      skilledTags: (widget.userProfile['skilled_tags'] as List<dynamic>?)
          ?.cast<String>() ??
          [],
      isEdit: isEdit,
    );
  }

  Widget _aboutMe(BuildContext context) {
    return AboutMe(
      birthdate: (widget.userProfile['birthdate'] as Timestamp?)
          ?.toDate()
          .toString()
          .substring(0, 10) ??
          '',
      age: widget.userProfile['age'] ?? '',
      mbti: widget.userProfile['mbti'] ?? '',
      workStyle: widget.userProfile['work_style'] ?? '',
      aboutMe: widget.userProfile['aboutme'] ?? '',
      isEdit: isEdit,
    );
  }

  Widget _folioWorks(BuildContext context) {
    return FolioWorks(
      isEdit: isEdit,
      videos: videos,
      files: files,
      links: links,
    );
  }

  Widget _socialContact(BuildContext context) {
    return SocialContact(
      isEdit: isEdit,
    );
  }

  Widget _isBackButton(BuildContext context) {
    if (isEdit) {
      return Positioned(
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
      );
    } else {
      return Container();
    }
  }
}
