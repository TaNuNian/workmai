import 'package:flutter/material.dart';
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

class _FriendChatPageState extends State<FriendChatPage> {
  get profilePicture => null;

  final List<String> exFriendMessage = [
    'Lorem ipsum dolor sit amet.',
    'Lorem ipsum.',
    'Nunc quis quam in dolor faucibus maximus. Suspendisse felis arcu, aliquam quis',
    'Nam et laoreet eros. Vestibulum quis interdum justo.',
  ];

  final List<String> exSelfMessage = [
    'Lorem ipsum dolor sit amet.',
    'Lorem ipsum.',
    'Nunc quis quam in dolor faucibus maximus. Suspendisse felis arcu, aliquam quis',
    'Nam et laoreet eros. Vestibulum quis interdum justo.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {},
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
            radius: 30,
            backgroundImage:
                profilePicture != null ? NetworkImage(profilePicture!) : null,
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
    return Container();
  }
}
