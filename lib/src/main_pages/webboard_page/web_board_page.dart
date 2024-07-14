import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/methods/cloud_firestore/userservice.dart';
import 'package:workmai/methods/cloud_firestore/web_board.dart';

class WebBoardPage extends StatefulWidget {
  final String webboardId;

  const WebBoardPage({Key? key, required this.webboardId,}) : super(key: key);

  @override
  _WebBoardPageState createState() => _WebBoardPageState();
}

class _WebBoardPageState extends State<WebBoardPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  late Future<Map<String, dynamic>?> _webboardData;
  late Future<Map<String, dynamic>?> _userData;
  bool _isLiked = false;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _webboardData = FirebaseFirestore.instance.collection('webboard').doc(widget.webboardId).get().then((doc) => doc.data() as Map<String, dynamic>?);
    _webboardData.then((data) {
      if (data != null) {
        _userData = FriendService().fetchFriendData(data['userId']);
        _isLiked = (data['likedBy'] as List).contains(user?.uid);
        _likeCount = data['likes'] ?? 0;
        setState(() {});
      }
    });
  }

  Future<void> _toggleLike() async {
    await WebboardService().toggleLikePost(widget.webboardId, user!.uid);
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _webboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          return FutureBuilder<Map<String, dynamic>?>(
            future: _userData,
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (userSnapshot.hasError) {
                return Center(child: Text('Error: ${userSnapshot.error}'));
              } else if (!userSnapshot.hasData) {
                return const Center(child: Text('No user data available'));
              }

              final userData = userSnapshot.data!;
              return _body(context, data, userData);
            },
          );
        },
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      title: const Text('Web Board'),
      titleTextStyle: GoogleFonts.raleway(
        color: const Color(0xff327B90),
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _body(BuildContext context, Map<String, dynamic> data, Map<String, dynamic> userData) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Column(
          children: [
            _banner(data['imageUrl']),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: userData['profilePicture'] != null
                          ? NetworkImage(userData['profilePicture'])
                          : null,
                      child: userData['profilePicture'] == null
                          ? const Icon(Icons.person, size: 30, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _displayname(userData['displayName']),
                        _date(data['timestamp']),
                      ],
                    ),
                  ],
                ),
                _commentlike(),
              ],
            ),
            const SizedBox(height: 8),
            _textbody(data['content'])
          ],
        ),
      ),
    );
  }

  Widget _banner(String? imageUrl) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(20),
        image: imageUrl != null
            ? DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        )
            : null,
      ),
    );
  }

  Widget _displayname(String? displayName) {
    return Text(
      displayName ?? 'NAME',
      style: GoogleFonts.raleway(
        color: const Color(0xffA9D95A),
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _date(Timestamp? timestamp) {
    final date = timestamp?.toDate();
    final formattedDate = date != null ? '${date.day}/${date.month}/${date.year}' : 'dd/mm/yy';
    return Text(
      formattedDate,
      style: GoogleFonts.raleway(
        color: const Color(0xff327B90),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _textbody(String? content) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        content ?? 'No content available',
        style: GoogleFonts.raleway(
          color: const Color(0xff000000),
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _commentlike() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.comment,
            color: Colors.grey,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: _toggleLike,
              icon: Icon(
                Icons.thumb_up,
                color: _isLiked ? Colors.blue : Colors.grey,
              ),
            ),
            Text(
              '$_likeCount',
              style: GoogleFonts.raleway(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
