import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/cloud_firestore/chat.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/src/main_pages/chat_page/bbgen_friend_chat_page.dart';

class ChatListTile extends StatefulWidget {
  final Color color;
  final String uid;
  final bool isFriend;

  const ChatListTile({
    super.key,
    required this.color,
    required this.uid,
    required this.isFriend,
  });

  @override
  _ChatListTileState createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  final ChatService _chatService = ChatService();
  final FriendService _friendService = FriendService();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? _friendData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFriendData();
  }

  Future<void> _fetchFriendData() async {
    try {
      final friendData = await _friendService.fetchFriendData(widget.uid);
      setState(() {
        _friendData = friendData;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching friend data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_friendData == null) {
      return Center(child: Text('Failed to load friend data'));
    }

    return GestureDetector(
      onTap: () async {
        if (currentUser != null) {
          try {
            final String chatId = await _chatService.createChatOrGetChatId(
              currentUser!.uid,
              widget.uid,
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BbgenFriendChatPage(
                  displayname: _friendData!['displayName'],
                  username: _friendData!['name'],
                  profilePicture: _friendData!['profilePicture'],
                  uid: widget.uid,
                  isFriend: widget.isFriend,
                  chatId: chatId,
                ),
              ),
            );
          } catch (e) {
            print('Error creating or getting chat ID: $e');
          }
        }
      },
      onLongPress: () {
        return;
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: _friendData!['profilePicture'] != null &&
                  _friendData!['profilePicture'] != ''
                  ? NetworkImage(_friendData!['profilePicture'])
                  : null,
              child: _friendData!['profilePicture'] == null ||
                  _friendData!['profilePicture'] == ''
                  ? const Icon(Icons.person, size: 30)
                  : null,
            ),
            title: Text(
              _friendData!['displayName'] != ''
                  ? _friendData!['displayName']
                  : 'No Display Name',
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            titleTextStyle: GoogleFonts.raleway(color: const Color(0xff1E1E1E)),
            subtitle: Text(
              'Self or User: ${_friendData!['name']}',
            ),
            subtitleTextStyle: GoogleFonts.raleway(
              color: const Color(0xff1E1E1E),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
