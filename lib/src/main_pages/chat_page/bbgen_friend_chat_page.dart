import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class BbgenFriendChatPage extends StatefulWidget {
  final String? displayname;
  final String? username;
  final String? profilePicture;
  final String? uid;

  const BbgenFriendChatPage({
    super.key,
    this.displayname,
    this.username,
    this.profilePicture,
    this.uid,
  });

  @override
  _BbgenFriendChatPageState createState() => _BbgenFriendChatPageState();
}

class _BbgenFriendChatPageState extends State<BbgenFriendChatPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _textEditingController;
  late final TabController _tabController;

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
              Navigator.pushNamed(context, '/aigen-chat-setting-work');
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
            backgroundImage: widget.profilePicture != null && widget.profilePicture!.isNotEmpty
                ? NetworkImage(widget.profilePicture!)
                : null,
            backgroundColor: Colors.lightBlueAccent,
            child: (widget.profilePicture == null || widget.profilePicture!.isEmpty)
                ? const Icon(Icons.person, size: 30)
                : null, // TODO: CHANGE TO USER PROFILE IMAGE
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.displayname != null && widget.displayname!.isNotEmpty ? widget.displayname! : 'Display Name',
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
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ChatMessageWidget(
                message: messages[index],
                isSameUser: index > 0
                    ? messages[index].isSender == messages[index - 1].isSender
                    : true,
              );
            },
          ),
        ),

        // Bottom Tab
        _bottomTab(context),
      ],
    );
  }

  _bottomTab(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        color: const Color(0xffD7E9BA),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _subTabItem(),
              Expanded(
                child: _tabItem(),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.send),
                color: const Color(0xff327B90),
                iconSize: 28,
                onPressed: () {
                  _sendMessage(); // TODO: Send Message
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _subTabItem() {
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

  _tabItem() {
    return Container(
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
    );
  }

  void _sendMessage() {
    if (_textEditingController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          text: _textEditingController.text.trim(),
          isSender: true,
        ));
        _textEditingController.clear();
      });
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
  final bool isSameUser;

  ChatMessageWidget({required this.message, this.isSameUser = false});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double chatWidth = width * 0.7;
    const double padding = 16.0;
    final double maxWidth = chatWidth - 2 * padding;
    const double minWidth = 100;
    double messageWidth = message.text.length > 100
        ? maxWidth
        : min(maxWidth, message.text.length * 8);

    if (isSameUser) {
      messageWidth += padding;
    }

    return Align(
      alignment:
          message.isSender ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Container(
        width: messageWidth,
        padding: EdgeInsets.all(padding),
        margin: EdgeInsets.symmetric(horizontal: padding, vertical: 8.0),
        decoration: BoxDecoration(
          color: message.isSender ? Colors.blue[200] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
