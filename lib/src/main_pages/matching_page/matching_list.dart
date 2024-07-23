import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/matching_user_provider.dart';
import 'package:workmai/src/decor/match_result_tile.dart';

class MatchingList extends StatefulWidget {
  const MatchingList({super.key});

  @override
  State<MatchingList> createState() => _MatchingListState();
}

class _MatchingListState extends State<MatchingList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'YOUR SELECTED MATCHING',
        style: GoogleFonts.raleway(
          color: const Color(0xff327B90),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: BackButton(
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Consumer<MatchingUserProvider>(
      builder: (context, userProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: userProvider.uids.length,
            itemBuilder: (context, index) {
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userProvider.uids[index])
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.hasError) {
                    return ListTile(
                      title: Text('Error loading user data'),
                    );
                  }

                  var userData = snapshot.data!.data() as Map<String, dynamic>;
                  var profile = userData['profile'];

                  return MatchResultTile(
                    color: Color(0xff327B90), // Adjust as needed
                    displayname: profile['display_name'] ?? 'N/A',
                    username: profile['name'] ?? 'N/A',
                    profilePicture: profile['profilePicture'] ?? '',
                    uid: userProvider.uids[index],
                    alreadyMatch: true,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
