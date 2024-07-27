import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectTitleWidget extends StatelessWidget {
  final String projectTitle;

  const ProjectTitleWidget({Key? key, required this.projectTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        projectTitle,
        style: GoogleFonts.raleway(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: const Color(0xff327B90),
        ),
      ),
    );
  }
}
