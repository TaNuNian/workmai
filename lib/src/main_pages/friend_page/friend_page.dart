import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FRIENDS', style: GoogleFonts.sarabun(fontSize: 32),), backgroundColor: Colors.transparent,),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
