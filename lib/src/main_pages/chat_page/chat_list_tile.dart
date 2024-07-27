import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/cloud_firestore/chat.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/src/main_pages/chat_page/bbgen_group_chat_page.dart';
import 'package:workmai/src/main_pages/chat_page/bbgen_private_chat_page.dart';

class ChatListTile extends StatefulWidget {
  final Color color;
  final String chatId;
  final String chatType; // 'private' or 'group'
  final bool isFriend; // 'friend' or 'co-worker'
  final String groupName;
  final String groupProfilePicture;

  const ChatListTile({
    super.key,
    required this.color,
    required this.chatId,
    required this.chatType,
    required this.isFriend,
    required this.groupName,
    required this.groupProfilePicture,
  });

  @override
  _ChatListTileState createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  final ChatService _chatService = ChatService();
  final FriendService _friendService = FriendService();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? _friendData;
  String _otherId = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.chatType == 'private') {
      _fetchFriendData();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchFriendData() async {
    try {
      final chatData = await _chatService.getChatData(widget.chatId);
      if (chatData != null && chatData['members'] != null) {
        final members = List<String>.from(chatData['members']);
        final otherUserId = members.firstWhere((id) => id != currentUser!.uid);
        final friendData = await _friendService.fetchFriendData(otherUserId);
        print(friendData);
        setState(() {
          _friendData = friendData;
          _otherId = otherUserId;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
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

    if (widget.chatType == 'private' && _friendData == null) {
      return Center(child: Text('Failed to load friend data'));
    }

    return GestureDetector(
      onTap: () async {
        if (currentUser != null) {
          try {
            if (widget.chatType == 'private') {
              print(_otherId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BbgenPrivateChatPage(
                    displayname: _friendData!['displayName'] ?? '',
                    username: _friendData!['name'] ?? '',
                    profilePicture: _friendData!['profilePicture'] ?? '',
                    uid: _otherId,
                    isFriend: widget.isFriend,
                    chatId: widget.chatId,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BbgenGroupChatPage(
                    groupName: widget.groupName,
                    groupProfilePicture: widget.groupProfilePicture,
                    chatId: widget.chatId,
                    isFriend: widget.isFriend,
                  ),
                ),
              );
            }
          } catch (e) {
            print('Error navigating to chat page: $e');
          }
        }
      },
      child: Container(
        height: 75,
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: widget.chatType == 'private' &&
                  _friendData!['profilePicture'] != null &&
                  _friendData!['profilePicture'] != ''
                  ? NetworkImage(_friendData!['profilePicture'])
                  : widget.chatType == 'group' &&
                  widget.groupProfilePicture.isNotEmpty
                  ? NetworkImage(widget.groupProfilePicture)
                  : null,
              child: (widget.chatType == 'private' &&
                  (_friendData!['profilePicture'] == null ||
                      _friendData!['profilePicture'] == '')) ||
                  (widget.chatType == 'group' &&
                      widget.groupProfilePicture.isEmpty)
                  ? Icon(
                widget.chatType == 'private'
                    ? Icons.person
                    : Icons.group,
                size: 30,
              )
                  : null,
            ),
            title: Text(
              widget.chatType == 'private'
                  ? (_friendData!['displayName'] == '' ? 'Display Name' : _friendData!['displayName'])
                  : widget.groupName,
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: widget.chatType == 'private'
                ? Text(
              'Self or User: ${_friendData!['name']}',
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
                : null,
          ),
        ),
      ),
    );
  }
}
