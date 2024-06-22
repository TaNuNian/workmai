import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagsChip extends StatelessWidget {
  const TagsChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Wrap(
            alignment: WrapAlignment.start,
            spacing: 4,
            runSpacing: 4,
            children: List<Widget>.generate(5 /*TODO: Apply chip to user's tags database*/, (index) {
              return chips(index);
            })
          );
        },
        itemCount: 1,
      ),
    );
  }

  // TODO: Apply chip to user's tags database

  Widget chips(index) {
    return Chip(
      label: Text(
        'Tags $index',
        style: GoogleFonts.sarabun(color: Colors.red),
      ),
      elevation: 0,
      backgroundColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
