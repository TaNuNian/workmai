import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/match_result_tile.dart';
import 'package:workmai/src/decor/match_subresult_tile.dart';

class MatchingResultPage extends StatelessWidget {
  final List<dynamic> matchedUsers;
  final List<Color> colorList = [
    const Color(0xff327B90),
    const Color(0xff69B1AF),
    const Color(0xffA1E8CF),
  ];

  MatchingResultPage({super.key, required this.matchedUsers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(context),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Text(
        'RESULT',
        style: GoogleFonts.raleway(
          color: const Color(0xff327B90),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
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
    print('Result List: $matchedUsers');
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.4,
      child: matchedUsers.isEmpty
          ? Center(child: Text('No matches found.'))
          : ListView.builder(
        itemCount: matchedUsers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: MatchResultTile(
              color: colorList[index % colorList.length],
              displayname: matchedUsers[index]['displayName'] ?? 'N/A',
              username: matchedUsers[index]['username'] ?? 'N/A',
              profilePicture: matchedUsers[index]['profilePicture'] ?? '',
              stars: matchedUsers[index]['stars']?.toString() ?? '0',
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
          padding: const EdgeInsets.all(8.0),
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
          child: matchedUsers.isEmpty
              ? Center(child: Text('No other matches found.'))
              : ListView.builder(
            itemCount: matchedUsers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: MatchSubResultTile(
                  color: const Color(0xffd5ffdf),
                  displayname: matchedUsers[index]['displayName'] ?? 'N/A',
                  username: matchedUsers[index]['username'] ?? 'N/A',
                  profilePicture: matchedUsers[index]['profilePicture'] ?? '',
                  stars: matchedUsers[index]['stars']?.toString() ?? '0',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
