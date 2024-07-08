import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/cloud_firestore/chat.dart';
import 'package:workmai/src/main_pages/chat_page/bbgen_friend_chat_setting.dart';
import 'package:workmai/src/main_pages/chat_page/bbgen_work_chat_setting.dart';

class BbgenFriendChatPage extends StatefulWidget {
  final String? displayname;
  final String? username;
  final String? profilePicture;
  final String? uid;
  final bool isFriend;
  final String chatId;

  const BbgenFriendChatPage({
    super.key,
    this.displayname,
    this.username,
    this.profilePicture,
    this.uid,
    required this.isFriend,
    required this.chatId,
  });

  @override
  _BbgenFriendChatPageState createState() => _BbgenFriendChatPageState();
}

class _BbgenFriendChatPageState extends State<BbgenFriendChatPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _textEditingController;
  late final TabController _tabController;
  final ChatService _chatService = ChatService();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  final List<ChatMessage> messages = [];

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _textEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(context),
      // bottomNavigationBar: _bottomTab(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xff327B91)),
        iconSize: 28,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: _appbarTitle(context),
      toolbarHeight: 80,
      backgroundColor: const Color(0xffD7E9BA),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {
              if (widget.isFriend) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BbgenFriendChatSetting()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BbgenWorkChatSetting()));
              }
            },
            icon: const Icon(Icons.menu),
            color: const Color(0xff327B91),
            iconSize: 32,
          ),
        )
      ],
    );
  }

  Widget _appbarTitle(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: widget.profilePicture != null &&
                    widget.profilePicture!.isNotEmpty
                ? NetworkImage(widget.profilePicture!)
                : null,
            backgroundColor: Colors.lightBlueAccent,
            child: (widget.profilePicture == null ||
                    widget.profilePicture!.isEmpty)
                ? const Icon(Icons.person, size: 30)
                : null,
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.displayname != null && widget.displayname!.isNotEmpty
                    ? widget.displayname!
                    : 'Display Name',
                style: GoogleFonts.raleway(
                    color: const Color(0xff327B90),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '@${widget.username ?? 'username'}',
                style: GoogleFonts.raleway(
                    color: const Color(0xff327B90),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: <Widget>[
        // Chat
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _chatService.getMessagesStream(widget.chatId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No messages'));
              }
              final messages = snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return ChatMessage(
                  text: data['text'] ?? '',
                  isSender: data['senderId'] == currentUser!.uid,
                );
              }).toList();
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatMessageWidget(
                    message: messages[index],
                  );
                },
              );
            },
          ),
        ),

        // Bottom Tab
        _bottomTab(context),
      ],
    );
  }

  Widget _bottomTab(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        color: const Color(0xffD7E9BA),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _bottomTabItem(),
        ),
      ),
    );
  }

  Widget _bottomTabItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _subTabItem(),
        _tabItem(),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.send),
          color: const Color(0xff327B90),
          iconSize: 28,
          onPressed: _sendMessage,
        ),
      ],
    );
  }

  Widget _subTabItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.add_circle_outline),
          color: const Color(0xff327B90),
          iconSize: 28,
          onPressed: () {},
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.photo_camera_outlined),
          color: const Color(0xff327B90),
          iconSize: 28,
          onPressed: () {},
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.image_outlined),
          color: const Color(0xff327B90),
          iconSize: 28,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _tabItem() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Center(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: GoogleFonts.raleway(
                  color: const Color(0xffABABAB),
                ),
                disabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendMessage() async {
    if (_textEditingController.text.trim().isNotEmpty) {
      try {
        await _chatService.sendMessage(
            widget.chatId, _textEditingController.text.trim());
        setState(() {
          messages.add(ChatMessage(
            text: _textEditingController.text.trim(),
            isSender: true,
          ));
          _textEditingController.clear();
        });
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }
}

class ChatMessage {
  final String text;
  final bool isSender;

  ChatMessage({required this.text, required this.isSender});
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: message.isSender ? Colors.blue[200] : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: message.isSender ? Radius.circular(15) : Radius.circular(0),
            bottomRight: message.isSender ? Radius.circular(0) : Radius.circular(15),
          ),
        ),
        child: Text(
          message.text,
          style: GoogleFonts.sarabun(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }}
