import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagsChip extends StatelessWidget {
  final List<dynamic> tags;
  const TagsChip({super.key, required this.tags});

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
            children:tags.map((tag) {
              return chips(tag);
            }).toList(),
          );
        },
        itemCount: 1,
      ),
    );
  }

  // TODO: Apply chip to user's tags database

  Widget chips(String tag) {
    return Chip(
      label: Text(
        tag,
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
