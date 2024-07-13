import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/padding.dart';

class WebBoardPage extends StatefulWidget {
  const WebBoardPage({super.key});

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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                  ),
                  const SizedBox(width: 8), // Space between avatar and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NAME',
                        style: GoogleFonts.raleway(
                          color: const Color(0xffA9D95A),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Additional details can be added here
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Add other widgets here
            ],
          ),
        ),
      ),
    );
  }
}
