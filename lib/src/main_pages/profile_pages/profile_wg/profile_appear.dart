import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:workmai/src/main_pages/profile_pages/profile_wg/myprofile_appear_name.dart';

class ProfileAppear extends StatelessWidget {
  final Widget button;

  const ProfileAppear({super.key, required this.button});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.4,
      // decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          // Background Banner
          Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            decoration: const BoxDecoration(
              // Default is Color(0xff59a1b6)
              color: Color(0xff59a1b6),
            ),

            // child: , TODO: ADD BG USER IMAGE
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            child: Center(
              child: Stack(
                children: <Widget>[

                  // Profile-Display-Username--DisplayTag
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyprofileAppearName(
                        username: 'username',
                      ),
                    ],
                  ),

                  // Edit Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: button,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
