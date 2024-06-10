import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/model/profile.dart';

import 'create_acc_birthday_header.dart';

class CreateAccBirthday extends StatefulWidget {
  final Profile profile;
  const CreateAccBirthday({super.key, required this.profile});

  @override
  _CreateAccBirthdayState createState() => _CreateAccBirthdayState();
}

class _CreateAccBirthdayState extends State<CreateAccBirthday> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          CreateAccBirthdayHeader(profile: widget.profile,),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xffEEECEC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Text(
                '', // TODO: SHOW SELECTED BIRTHDAY
                style: GoogleFonts.sarabun(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
