import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/user_provider.dart';

import 'package:workmai/src/decor/padding.dart';

class AboutMe extends StatelessWidget {
  // TODO: Display age / activetime on Text
  // final int age;
  // final String activetime;

  const AboutMe({
    super.key,
    // required this.age,
    // required this.activetime
  });

  @override
  Widget build(BuildContext context) {
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
                  style: GoogleFonts.sarabun(
                    color: const Color(0xff59A1B6),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.userData == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final profile = userProvider.userData!["profile"];
              final keys = {
                "Birthdate": profile["birthdate"] != null
                    ? (profile["birthdate"] as Timestamp).toDate().toString().substring(0,10)
                    : null,
                "Age": profile["age"]?.toString(),
                "MBTI": profile["mbti"],
                "Work Style": profile["work_style"],
                "About Me": profile["aboutme"],
              };

              List<String> details = [];
              keys.forEach((key, value) {
                if (value != null && value.isNotEmpty) {
                  if (key == "About Me") {
                    details.add("\n$value");
                  }else{
                    details.add("$key: $value");
                  }
                }
              });

              return Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xffE5F1D3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    details.join('\n'),
                    style: GoogleFonts.sarabun(
                      color: const Color(0xff59A1B6).withOpacity(0.65),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
