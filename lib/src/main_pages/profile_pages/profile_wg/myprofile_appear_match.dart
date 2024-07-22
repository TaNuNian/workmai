import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/model/matching_user_provider.dart';
import 'package:workmai/src/decor/gradients.dart';

class MyprofileAppearMatch extends StatelessWidget {
  final String? uid;
  const MyprofileAppearMatch({super.key, required this.uid,});

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
            Provider.of<MatchingUserProvider>(context, listen: false).addUser(uid.toString());
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent
          ),
          child: Text(
            'ADD TO MATCH',
            style: GoogleFonts.raleway(
                color: Colors.white,
                fontSize: 13,
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
