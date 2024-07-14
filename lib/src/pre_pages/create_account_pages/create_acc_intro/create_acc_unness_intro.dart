import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/category.dart';
import 'package:workmai/methods/cloud_firestore/cloud_firestore.dart';
import 'package:workmai/methods/cloud_firestore/co_worker_service.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/methods/cloud_firestore/rank.dart';
import 'package:workmai/methods/cloud_firestore/reviews.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/custom_appbar/custom_appbar.dart';
import 'package:workmai/src/decor/gradients.dart';
import 'package:workmai/src/decor/padding.dart';

class CreateAccUnnessIntro extends StatelessWidget {
  const CreateAccUnnessIntro({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(gradient: mainLinearGradient),
            ),
            Padding(
              padding: bodyPadding(context),
              child: Container(
                // color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomAppbar(
                      appbarColor: Colors.transparent,
                    ),
                    Text(
                      'Please share us the other details about yourself?\n\nFor stepping up your experiences!',
                      style: GoogleFonts.raleway(
                        color: const Color(0xffffffff),
                        shadows: [
                          const Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 5,
                            color: Color.fromRGBO(150, 150, 150, 1),
                          ),
                        ],
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 120,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final profileProvider =
                                  Provider.of<ProfileProvider>(context,
                                      listen: false);
                              final birthdateTimestamp = Timestamp.fromDate(
                                  profileProvider.profile.birthdate!);
                              final user = FirebaseAuth.instance.currentUser;
                              final userid = user?.uid;
                              final lower_name = profileProvider.profile.name;
                              final FriendService friendservice = FriendService();
                              final CoWorkerService coworkerservice = CoWorkerService();
                              final Reviews reviews  = Reviews();
                              final RankService rank = RankService();
                              profileProvider.setNameLowerCase(lower_name!);
                              if (userid != null) {
                                await CloudFirestore().addUser(
                                  userid,
                                  '',
                                  profileProvider.profile.name ?? "",
                                  profileProvider.profile.nameLowerCase ?? "",
                                  profileProvider.profile.gender ?? "",
                                  profileProvider.profile.age ?? 0,
                                  birthdateTimestamp,
                                  profileProvider.profile.interested_tags ?? [],
                                  profileProvider.profile.skilled_tags ?? [],
                                  '',
                                  [],
                                  '',
                                  '',
                                );
                                await AddCategory().categoryInterested(userid, profileProvider.profile.interested_tags ?? []);
                                await AddCategory().categorySkilled(userid, profileProvider.profile.skilled_tags ?? []);
                                await friendservice.createFriendsArray();
                                await friendservice.createFriendRequests();
                                await coworkerservice.createCoWorkersArray();
                                await reviews.createUser(userid);
                                await rank.createInitialRank(userid);
                              }

                              Navigator.pushNamed(context, '/bottomnav');
                            },
                            child: Text(
                              'No,Thanks',
                              style: GoogleFonts.raleway(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/create-acc-unness');
                            },
                            child: Text(
                              'Next',
                              style: GoogleFonts.raleway(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
