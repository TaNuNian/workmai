import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: body(context),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: const BackButton(color: Color(0xffFFFFFF),),
      title: Text(
        'RANK',
        style: GoogleFonts.raleway(
          color: const Color(0xffFFFFFF),
        ),
      ),
      backgroundColor: const Color(0xff327B90),
    );
  }

  Widget body(BuildContext context) {
    return Text('SAD :(');
  }
}
