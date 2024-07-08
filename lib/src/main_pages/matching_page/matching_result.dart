import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/animation/match_result_tile.dart';
import 'package:workmai/src/decor/padding.dart';

class MatchingResult extends StatefulWidget {
  const MatchingResult({super.key});

  @override
  _MatchingResultState createState() => _MatchingResultState();
}

class _MatchingResultState extends State<MatchingResult> {
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
    return Padding(
      padding: bodyPadding(context),
      child: Container(
        color: Colors.pinkAccent,
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return MatchResultTile(color: Color(0xff), displayname: '', recentMsg: '',);
              },
            ),
          ],
        ),
      ),
    );
  }
}
