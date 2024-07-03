import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/profile_picker.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/myprofile_appear_name.dart';

class ProfileAppear extends StatefulWidget {
  final Widget button;
  final String? backgroundPicture;
  final String? name;
  final String? display_name;
  final String? profilePicture;

  const ProfileAppear({
    super.key,
    required this.button,
    required this.backgroundPicture,
    required this.name,
    required this.display_name,
    required this.profilePicture,
  });

  @override
  _ProfileAppearState createState() => _ProfileAppearState();
}

class _ProfileAppearState extends State<ProfileAppear> {
  @override
  Widget build(BuildContext context) {
    print(widget.name);
    print(widget.display_name);
    print(widget.backgroundPicture);
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
                  image: widget.backgroundPicture != null
                      ? DecorationImage(
                    image: NetworkImage(widget.backgroundPicture!),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyprofileAppearName(
                        username: widget.name,
                        display_name: widget.display_name,
                        profilePicture: widget.profilePicture,
                      ),
                    ],
                  ),

                  // Edit Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: widget.button,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
