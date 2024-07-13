import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebBoardPage extends StatefulWidget {
  const WebBoardPage({Key? key}) : super(key: key);

  @override
  _WebBoardPageState createState() => _WebBoardPageState();
}

class _WebBoardPageState extends State<WebBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar();
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _banner(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                      ),
                      const SizedBox(width: 12),
                      // Space between avatar and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _displayname(),
                          _date(),
                        ],
                      ),
                    ],
                  ),
_commentlike(),                ],
              ),
              const SizedBox(height: 8),
              _textbody()
            ],
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    return Container(
      height: 200, // Adjust the height as needed
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _displayname() {
    return Text(
      'NAME',
      style: GoogleFonts.raleway(
        color: const Color(0xffA9D95A),
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _date() {
    return Text(
      'dd/mm/yy',
      style: GoogleFonts.raleway(
        color: const Color(0xff327B90),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _textbody() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        'yapyapyapyapyapyapyapyapyapyapyapyapyapyap',
        style: GoogleFonts.raleway(
          color: const Color(0xff000000),
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _commentlike() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.comment,
            color: Colors.grey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.thumb_up,
            color: Colors.grey,
          ),
        ),
      ],
    )
    ;
  }
}
