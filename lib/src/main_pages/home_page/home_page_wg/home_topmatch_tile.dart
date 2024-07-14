import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget listCardZero(BuildContext context, Map<String, dynamic> user) {
  return Container(
    width: 150,
    decoration: BoxDecoration(
      color: const Color(0xff67B4CA),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                backgroundImage: user['profilePicture'] != null
                    ? NetworkImage(user['profilePicture'])
                    : null,
                child: user['profilePicture'] == null
                    ? const Icon(Icons.person, size: 40)
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Text(
                  user['name'],
                  style: GoogleFonts.raleway(
                    color: const Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user['username'],
                  style: GoogleFonts.raleway(
                    color: const Color(0xffffffff),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xff2A4B54),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget listCardnonZero(BuildContext context, Map<String, dynamic> user) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 150,
        height: 140,
        decoration: BoxDecoration(
          color: const Color(0xff67B4CA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    backgroundImage: user['profilePicture'] != null
                        ? NetworkImage(user['profilePicture'])
                        : null,
                    child: user['profilePicture'] == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                user['name'],
                style: GoogleFonts.raleway(
                  color: const Color(0xffffffff),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user['username'],
                style: GoogleFonts.raleway(
                  color: const Color(0xffffffff),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
