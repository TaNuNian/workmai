import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/category.dart';
import 'package:workmai/methods/cloud_firestore/cloud_firestore.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/decor/gradients.dart';

class FinishButton extends StatefulWidget {
  final String? actionName;
  final String routeName;

  const FinishButton({
    super.key,
    this.actionName,
    required this.routeName,
  });

  @override
  _FinishButtonState createState() => _FinishButtonState();
}

class _FinishButtonState extends State<FinishButton> {
  String get actionName => widget.actionName ?? '';
  String get routeName => widget.routeName;

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    double width = MediaQuery.sizeOf(context).width * 0.4;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: MediaQuery.sizeOf(context).height * 0.06,
        decoration: BoxDecoration(
          gradient: crossLinearGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: () async {
            final birthdateTimestamp = Timestamp.fromDate(
                profileProvider.profile.birthdate!);
            final user = FirebaseAuth.instance.currentUser;
            final userid = user?.uid;
            final lower_name = profileProvider.profile.name;
            profileProvider.setNameLowerCase(lower_name!);
            if (userid != null) {
              await CloudFirestore().addUser(
                userid,
                '',
                profileProvider.profile.name ?? "",
                profileProvider.profile.nameLowerCase ?? "",
                profileProvider.profile.gender?? "",
                profileProvider.profile.age ?? 0,
                birthdateTimestamp,
                profileProvider.profile.interested_tags ?? [],
                profileProvider.profile.skilled_tags ?? [],
                profileProvider.profile.mbti ?? '',
                profileProvider.profile.active_time ?? [],
                profileProvider.profile.work_style ?? '',
                profileProvider.profile.aboutme ?? '',
              );
              await AddCategory().categoryInterested(userid, profileProvider.profile.interested_tags ?? []);
              await AddCategory().categorySkilled(userid, profileProvider.profile.skilled_tags ?? []);
            }

            Navigator.pushNamed(context, routeName);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              actionName,
              style: GoogleFonts.sarabun(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
