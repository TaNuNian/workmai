import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHATS',
          style: GoogleFonts.sarabun(fontSize: 32),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
