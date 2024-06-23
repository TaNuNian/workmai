import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/chip.dart';

class InterTag extends StatelessWidget {
  const InterTag({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'INTEREST TAGS',
                  style: GoogleFonts.sarabun(
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
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xffA6EDD1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TagsChip(),
          ),
        ],
      ),
    );
  }
}
