import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';

class MyprofileAppearAdd extends StatelessWidget {
  const MyprofileAppearAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height * 0.1,
      ),
      child: Container(
        width: 150,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: crossLinearGradient,
        ),
        child: ElevatedButton(
          onPressed: () {
            // TODO: ADD FRIEND
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent
          ),
          child: Text(
            'ADD FRIEND',
            style: GoogleFonts.raleway(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),

        // child: GestureDetector(
        //   onTap: () {
        //     // TODO: EDIT PROFILE PAGE
        //   },
        //   child: Container(
        //     width: double.infinity,
        //     height: double.infinity,
        //     decoration: BoxDecoration(
        //         color: const Color(0xff69B5CB),
        //         shape: BoxShape.rectangle,
        //         borderRadius: BorderRadius.circular(20)),
        //     child: const Icon(
        //       Icons.edit,
        //       color: Color(0xffffffff),
        //       size: 30,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
