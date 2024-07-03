import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:workmai/src/decor/padding.dart';

class AboutMe extends StatelessWidget {
  final String birthdate;
  final int age;
  final String mbti;
  final String workStyle;
  final String aboutMe;

  const AboutMe({
    super.key,
    required this.birthdate,
    required this.age,
    required this.mbti,
    required this.workStyle,
    required this.aboutMe,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> keys = {
      "Birthdate": birthdate,
      "Age": age.toString(),
      "MBTI": mbti,
      "Work Style": workStyle,
      "About Me": aboutMe,
    };

    List<String> details = [];
    keys.forEach((key, value) {
      if (value.isNotEmpty) {
        if (key == "About Me") {
          details.add("\n$value");
        } else {
          details.add("$key: $value");
        }
      }
    });

    return Padding(
      padding: bodyPadding(context),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'ABOUT ME',
                  style: GoogleFonts.raleway(
                    color: const Color(0xff59A1B6),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xffE5F1D3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                details.join('\n'),
                style: GoogleFonts.sarabun(
                  color: const Color(0xff59A1B6).withOpacity(0.65),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
