import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workmai/src/decor/padding.dart';
import 'package:workmai/src/main_pages/profile_pages/my_profile_wg/myprofile_appear_name.dart';
import 'package:workmai/src/main_pages/profile_pages/my_profile_wg/myprofile_appear_edit.dart';

class MyProfileAppear extends StatelessWidget {
  const MyProfileAppear({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.4,
      // decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            decoration: const BoxDecoration(
                // Default is Color(0xff59a1b6)
                color: Color(0xff59a1b6)),
            // child: , TODO: ADD BG USER IMAGE
          ),
          Padding(
            padding: bodyPadding(context),
            child: Center(
                child: Container(
              height: double.infinity,
              width: double.infinity,
              // color: Colors.red,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile-Display-Username--DisplayTag
                  MyprofileAppearName(username: 'username', displayname: 'Display Name',),

                  // Edit Button
                  MyprofileAppearEdit(),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
