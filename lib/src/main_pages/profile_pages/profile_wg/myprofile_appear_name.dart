import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/profile_picker.dart';
import 'package:workmai/methods/user_provider.dart';

class MyprofileAppearName extends StatefulWidget {
  final String? username;
  final String? display_name;
  final String? profilePicture;
  final bool? isEdit;

  const MyprofileAppearName({
    super.key,
    required this.username,
    required this.display_name,
    required this.profilePicture,
    this.isEdit,
  });

  @override
  State<MyprofileAppearName> createState() => _MyprofileAppearNameState();
}

class _MyprofileAppearNameState extends State<MyprofileAppearName> {
  late bool isEdit;

  @override
  void initState() {
    super.initState();
    isEdit = widget.isEdit ?? false;
  }

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

  Widget _profilePic(context) {
    return GestureDetector(
      onTap: () {
        print('gesture-profile');
      },
      child: Column(
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
      ),
    );
  }

  Widget _consumerUsername(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.userData == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final displayName = widget.display_name;
            final userName = widget.username;
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        displayName != null && displayName.isNotEmpty
                            ? displayName
                            : 'Display name',
                        style: GoogleFonts.raleway(
                          color: const Color(0xff327B90),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      _editDisplay(context, isEdit),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '@${userName ?? 'username'}',
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
