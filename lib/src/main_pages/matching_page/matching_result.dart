import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/matching_user_provider.dart';
import 'package:workmai/src/decor/match_result_tile.dart';
import 'package:workmai/src/decor/match_subresult_tile.dart';
import 'package:badges/badges.dart' as badges;
import 'package:workmai/src/main_pages/matching_page/matching_list.dart';

class MatchingResultPage extends StatefulWidget {
  final List<dynamic> matchedUsers;
  final List<Color> colorList = [
    const Color(0xff327B90),
    const Color(0xff69B1AF),
    const Color(0xffA1E8CF),
  ];
  final String mode;

  MatchingResultPage({super.key, required this.matchedUsers, required this.mode});

  @override
  _MatchingResultPageState createState() => _MatchingResultPageState();
}

class _MatchingResultPageState extends State<MatchingResultPage> {
  List<Map<String, dynamic>> topMatchDetails = [];
  List<Map<String, dynamic>> subMatchDetails = [];

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    List<dynamic> topMatches = widget.matchedUsers.take(3).toList();
    List<dynamic> subMatches = widget.matchedUsers.skip(3).toList();

    for (var match in topMatches) {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(match['userId'])
          .get();
      var userData = userDoc.data();
      topMatchDetails.add({
        'displayName': userData?['profile']['display_name'] == ''
            ? 'Display Name'
            : userData?['profile']['display_name'],
        'username': userData?['profile']['name'] ?? 'N/A',
        'profilePicture': userData?['profile']['profilePicture'] == ''
            ? ''
            : userData?['profile']['profilePicture'],
        'stars': match['score'].toString(),
        'userId': match['userId'],
      });
    }

    for (var match in subMatches) {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(match['userId'])
          .get();
      var userData = userDoc.data();
      subMatchDetails.add({
        'displayName': userData?['profile']['display_name'] == ''
            ? 'Display Name'
            : userData?['profile']['display_name'],
        'username': userData?['profile']['name'] ?? 'N/A',
        'profilePicture': userData?['profile']['profilePicture'] == ''
            ? ''
            : userData?['profile']['profilePicture'],
        'stars': match['score'].toString(),
        'userId': match['userId'],
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(context),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Row(
        children: [
          Text(
            'RESULT',
            style: GoogleFonts.raleway(
              color: const Color(0xff327B90),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 150,
          ),
          badges.Badge(
            badgeContent: Consumer<MatchingUserProvider>(
              builder: (context, countProvider, child) {
                return Text(
                  countProvider.uids.length.toString(),
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MatchingList(isFriend: widget.mode == 'friends' ? true : false),
                ),
              ),
              icon: Icon(
                Icons.group,
                color: Color(0xff327B90),
                size: 30,
              ),
            ),
          ),
        ],
      ),
      leading: BackButton(
        onPressed: () => Navigator.pushNamed(context, '/bottomnav'),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Result List
          _resultList(context),
          _subresultList(context),
        ],
      ),
    );
  }

  Widget _resultList(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.4,
      child: topMatchDetails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: topMatchDetails.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: MatchResultTile(
              color: widget.colorList[index % widget.colorList.length],
              displayname: topMatchDetails[index]['displayName'] ?? 'N/A',
              username: topMatchDetails[index]['username'] ?? 'N/A',
              profilePicture: topMatchDetails[index]['profilePicture'] ?? '',
              stars: topMatchDetails[index]['stars']?.toString() ?? '0',
              uid: topMatchDetails[index]['userId'] ?? '',
              mode: topMatchDetails[index]['mode'] ?? '',
              alreadyMatch: false,
            ),
          );
        },
      ),
    );
  }

  Widget _subresultList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Other users that might match with you',
            maxLines: 2,
            style: GoogleFonts.raleway(
              color: const Color(0xff327B91),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Sub-Result List
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.3,
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: subMatchDetails.isEmpty
              ? Center(child: Text('No other matches found.'))
              : ListView.builder(
            itemCount: subMatchDetails.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: MatchSubResultTile(
                  color: const Color(0xffd5ffdf),
                  displayname: subMatchDetails[index]['displayName'] ?? 'N/A',
                  username: subMatchDetails[index]['username'] ?? 'N/A',
                  profilePicture: subMatchDetails[index]['profilePicture'] ?? '',
                  stars: subMatchDetails[index]['stars']?.toString() ?? '0',
                  uid: subMatchDetails[index]['userId'] ?? '',
                  mode: subMatchDetails[index]['mode'] ?? '',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
