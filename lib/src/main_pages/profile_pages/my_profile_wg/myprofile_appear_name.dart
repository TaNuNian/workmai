import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyprofileAppearName extends StatefulWidget {
  final String username;
  final String displayname;

  const MyprofileAppearName(
      {super.key, required this.username, required this.displayname});

  @override
  State<MyprofileAppearName> createState() => _MyprofileAppearNameState();
}

class _MyprofileAppearNameState extends State<MyprofileAppearName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        // color: Colors.purple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xffD9D9D9),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.displayname,
                    style: GoogleFonts.sarabun(
                      color: const Color(0xff327B90),
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '@${widget.username}',
                        style: GoogleFonts.sarabun(
                          color: const Color(0xff59A1B6),
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 160,
                        height: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xffc3e1ea),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Icon(Icons.military_tech),
                              Icon(Icons.star),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
