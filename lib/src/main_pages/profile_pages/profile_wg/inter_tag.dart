import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/chip.dart';

class InterTag extends StatelessWidget {
  final List<String> interestedTags;
  final bool? isEdit;

  const InterTag({super.key, required this.interestedTags, this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.01,
        horizontal: MediaQuery.sizeOf(context).width * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 6),
            child: _interTag(context),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xffA6EDD1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TagsChip(tags: interestedTags),
          ),
        ],
      ),
    );
  }

  Widget _interTag(BuildContext context) {
    if (isEdit == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'INTEREST TAGS',
            style: GoogleFonts.raleway(
              color: const Color(0xff327B90),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_circle_outline,
                color: Color(0xff327B90),
                size: 24,
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'INTEREST TAGS',
            style: GoogleFonts.raleway(
              color: const Color(0xff327B90),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      );
    }
  }
}
