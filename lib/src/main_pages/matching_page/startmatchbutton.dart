import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget startMatchButton(BuildContext context, String routes) {
  return SizedBox(
    height: 60,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, routes);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffE5F1D3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Start Matching',
            style: GoogleFonts.raleway(
              color: const Color(0xff327B90),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xff327B90),
          ),
        ],
      ),
    ),
  );
}
