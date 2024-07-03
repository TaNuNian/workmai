import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/model/profile.dart';

class CreateAccBirthdayHeader extends StatelessWidget {
  final Profile profile;

  const CreateAccBirthdayHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'วันเกิด',
            style: GoogleFonts.raleway(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          ),
        ],
      ),
    );
  }
}
