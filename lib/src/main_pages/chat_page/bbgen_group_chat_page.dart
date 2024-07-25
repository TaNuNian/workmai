import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/cloud_firestore/chat.dart';
import 'package:workmai/src/main_pages/chat_page/bbgen_group_chat_setting.dart';

class BbgenGroupChatPage extends StatefulWidget {
  final String groupName;
  final String groupProfilePicture;
  final String chatId;

  const BbgenGroupChatPage({
    super.key,
    required this.groupName,
    required this.groupProfilePicture,
    required this.chatId,
  });

  @override
  _BbgenGroupChatPageState createState() => _BbgenGroupChatPageState();
}

class _BbgenGroupChatPageState extends State<BbgenGroupChatPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _textEditingController;
  final ChatService _chatService = ChatService();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(context),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BbgenGroupChatSetting(
                    groupName: widget.groupName,
                    groupProfilePicture: widget.groupProfilePicture,
                  ),
                ),
              );
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
            backgroundImage: widget.groupProfilePicture.isNotEmpty
                ? NetworkImage(widget.groupProfilePicture)
                : null,
            backgroundColor: Colors.lightBlueAccent,
            child: widget.groupProfilePicture.isEmpty
                ? const Icon(Icons.group, size: 30)
                : null,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            widget.groupName,
            style: GoogleFonts.raleway(
              color: const Color(0xff327B90),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
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
  }
}
