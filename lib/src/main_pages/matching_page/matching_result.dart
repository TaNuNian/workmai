import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/match_result_tile.dart';
import 'package:workmai/src/decor/match_subresult_tile.dart';

class MatchingResultPage extends StatelessWidget {
  final List<Color> colorList = [
    const Color(0xff327B90),
    const Color(0xff69B1AF),
    const Color(0xffA1E8CF),
  ];

  MatchingResultPage({super.key});

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
        // mainAxisAlignment: MainAxisAlignment.center,
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
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: MatchResultTile(
              color: colorList[index],
              displayname: 'Display Name $index',
              username: '@username_$index',
              profilePicture: null,
              stars: '4.5',
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
            'Other user that might match\nwith you',
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
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4),
                child: MatchSubResultTile(
                  color: const Color(0xffd5ffdf),
                  displayname: 'Display Name $index',
                  username: '@username_$index',
                  profilePicture: null,
                  stars: '4.5',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
