import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/methods/cloud_firestore/web_board.dart';
import 'package:workmai/src/decor/search_tab.dart';
import 'package:workmai/src/decor/textfield_decor.dart';
import 'package:workmai/src/decor/theme.dart';
import 'package:workmai/src/main_pages/webboard_page/web_board_page.dart';

class WebBoardListPage extends StatefulWidget {
  const WebBoardListPage({super.key});

  @override
  _WebBoardListPageState createState() => _WebBoardListPageState();
}

class _WebBoardListPageState extends State<WebBoardListPage> {
  late final TextEditingController _textEditingController;
  final WebboardService _webboardService = WebboardService();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: _appbar(context),
        body: _body(context),
        floatingActionButton: _actionButton(context),
      ),
    );
  }

  _appbar(BuildContext context) {
    return AppBar(
      title: Text(
        'Web Board',
        style: appBarTitleStyle(const Color(0xff327B90)),
      ),
      centerTitle: true,
      elevation: 0,
      bottom: const TabBar(
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.blue,
        tabs: [
          Tab(text: 'All Posts'),
          Tab(text: 'My Posts'),
        ],
      ),
    );
  }

  _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            CustomSearchTab(
              child: TextField(
                controller: _textEditingController,
                decoration: textfieldSearchDec('Search'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _topicList(context, _webboardService.getTopicsStream()),
                  // All Posts
                  _topicList(
                      context, _webboardService.getUserPostsStream(user!.uid)),
                  // My Posts
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topicList(BuildContext context, Stream<QuerySnapshot> stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No topics available.'));
        }

        final topics = snapshot.data!.docs;

        return ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topic = topics[index].data() as Map<String, dynamic>;
            return FutureBuilder<Map<String, dynamic>?>(
              future: FriendService().fetchFriendData(topic['userId']),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (userSnapshot.hasError || !userSnapshot.hasData) {
                  return Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text('Error loading user data')),
                  );
                }

                final userData = userSnapshot.data!;
                final String contentPreview = topic['content'].length > 100
                    ? '${topic['content'].substring(0, 100)}...'
                    : topic['content'];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebBoardPage(
                          webboardId: topics[index].id,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (topic['imageUrl'] != null &&
                                topic['imageUrl'] != '')
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xffD9D9D9),
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(topic['imageUrl']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            if (topic['imageUrl'] == null ||
                                topic['imageUrl'] == '')
                              const SizedBox(width: 12),
                            const SizedBox(width: 12),
                            // Add some space between image and text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    topic['title'],
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xff327B90),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    contentPreview,
                                    style: GoogleFonts.raleway(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundImage:
                                            userData['profilePicture'] != ''
                                                ? NetworkImage(
                                                    userData['profilePicture'])
                                                : null,
                                        child: userData['profilePicture'] == ''
                                            ? const Icon(Icons.person,
                                                size: 12, color: Colors.black45)
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'by',
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xff6DD484),
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        userData['displayName'] != ''
                                            ? userData['displayName']
                                            : 'Display Name',
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xffB8E175),
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.thumb_up,
                                          color: Colors.grey, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${topic['likes']}',
                                        style: GoogleFonts.raleway(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  _actionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/webboard-create-page');
      },
      shape: const CircleBorder(),
      backgroundColor: const Color(0xff327B90),
      child: const Center(
        child: Icon(
          Icons.add,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }
}
