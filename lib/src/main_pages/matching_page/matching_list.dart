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
        return Stack(
          children: [
            Padding(
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

                      var userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      var profile = userData['profile'];

                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: MatchResultTile(
                          color: Color(0xff327B90),
                          // Adjust as needed
                          displayname: profile['display_name'] ?? 'N/A',
                          username: profile['name'] ?? 'N/A',
                          profilePicture: profile['profilePicture'] ?? '',
                          uid: userProvider.uids[index],
                          alreadyMatch: true,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => _modalContent(context),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff327B90)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _modalContent(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8, // Set initial height to 80% of screen height
          // minChildSize: 0.3, // Minimum height of the bottom sheet
          // maxChildSize: 0.9, // Maximum height of the bottom sheet
          expand: false,
          builder: (context, scrollController) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Options',
                    style: GoogleFonts.raleway(
                      color: const Color(0xff327B90),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  bottom: TabBar(
                    tabs: const [
                      Tab(text: 'Create'),
                      Tab(text: 'Invite'),
                    ],
                    labelColor: const Color(0xff327B90),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: const Color(0xff327B90),
                    indicatorWeight: 2.0,
                  ),
                ),
                body: TabBarView(
                  children: [
                    Center(child: Text('Create Tab Content')),
                    Center(child: Text('Invite Tab Content')),
                  ],
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Implement your request logic here
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Request',
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff327B90),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
