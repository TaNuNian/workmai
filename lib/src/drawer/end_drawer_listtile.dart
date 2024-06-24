import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EndDrawerListTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final String route;

  const EndDrawerListTile({super.key, required this.icon, required this.text, required this.route});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 35,
        color: const Color(0xff327B90),
      ),
      title: Text(
        text,
        style: GoogleFonts.raleway(
          color: const Color(0xff327B90),
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
