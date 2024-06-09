import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccBirthdayHeader extends StatelessWidget {
  const CreateAccBirthdayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'วันเกิด',
            style: GoogleFonts.sarabun(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,

            ),
            child: Text(
              'เลือกวันเกิด',
              style: GoogleFonts.sarabun(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff327B90)),
            ),
          )
        ],
      ),
    );
  }
}
