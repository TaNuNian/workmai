import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/profile_picker.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/myprofile_appear_name.dart';

class ProfileAppear extends StatelessWidget {
  final Widget button;

  const ProfileAppear({super.key, required this.button});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.4,
      child: Stack(
        children: [
          // Background Banner
          Consumer<UploadProfile>(
            builder: (context, uploadProfile, child) {
              return Container(
                height: MediaQuery.sizeOf(context).height * 0.2,
                decoration: BoxDecoration(
                  color: const Color(0xff59a1b6), // Default color
                  image: uploadProfile.userData?['profile']['backgroundPicture'] != null
                      ? DecorationImage(
                    image: NetworkImage(uploadProfile.userData!['profile']['backgroundPicture']),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
              );
            },
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
