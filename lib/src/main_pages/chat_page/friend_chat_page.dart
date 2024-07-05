import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendChatPage extends StatefulWidget {
  final String? displayname;
  final String? profilePicture;
  final String? uid;

  const FriendChatPage({
    super.key,
    this.displayname,
    this.profilePicture,
    this.uid,
  });

  @override
  _FriendChatPageState createState() => _FriendChatPageState();
}

class _FriendChatPageState extends State<FriendChatPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _textEditingController;
  late final TabController _tabController;

  get profilePicture => null;

  final List<String> exFriendMessage = [
    'Lorem ipsum.',
    'Nam et laoreet eros. Vestibulum quis interdum justo.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam venenatis, elit vitae faucibus convallis'
  ];

  final List<String> exSelfMessage = [
    'Lorem ipsum.',
    'Nam et laoreet eros. Vestibulum quis interdum justo.',
    'Nunc quis quam in dolor faucibus maximus. Suspendisse felis arcu, aliquam quis',
  ];

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
              Navigator.pushNamed(context, '/test-a');
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
            backgroundImage:
                profilePicture != null ? NetworkImage(profilePicture!) : null,
            backgroundColor: Colors.lightBlueAccent,
            child: profilePicture == null
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
                'Display name',
                style: GoogleFonts.raleway(
                    color: const Color(0xff327B90),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '@username',
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
          child: ListView(
            children: List.generate(exFriendMessage.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  color: Colors.red,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                    minWidth: MediaQuery.of(context).size.width * 0.3,
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                    minHeight: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Text(
                    exFriendMessage[index],
                    style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
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
          child: _bottomTabItem(),
        ),
      ),
    );
  }

  _bottomTabItem() {
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
          onPressed: () {},
        ),
      ],
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
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Center(
            child: _textfieldChat(),
          ),
        ),
      ),
    );
  }

  _textfieldChat() {
    return TextField(
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

// Guidance (AI มันเจนมา แปะๆไว้)
class ChatMessage {
  final String text;
  final bool isSender;

  ChatMessage({required this.text, required this.isSender});
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isSender? Alignment.bottomRight : Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: message.isSender? Colors.blue[200] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          message.text,
          style: GoogleFonts.sarabun(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}