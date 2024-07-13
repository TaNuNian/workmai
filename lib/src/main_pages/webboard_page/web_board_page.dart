import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/methods/cloud_firestore/web_board.dart';
import 'package:workmai/src/decor/search_tab.dart';
import 'package:workmai/src/decor/textfield_decor.dart';

class WebBoardPage extends StatefulWidget {
  const WebBoardPage({super.key});

  @override
  _WebBoardPageState createState() => _WebBoardPageState();
}

class _WebBoardPageState extends State<WebBoardPage> {
  late final TextEditingController _textEditingController;
  final WebboardService _webboardService = WebboardService();

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  _appbar(BuildContext context) {
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
            Expanded(child: _topicList(context)),
          ],
        ),
      ),
    );
  }

  Widget _topicList(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _webboardService.getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No topics available.'));
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
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (userSnapshot.hasError) {
                  return Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Text('Error: ${userSnapshot.error}')),
                  );
                } else if (!userSnapshot.hasData) {
                  return Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Text('User not found')),
                  );
                }

                final userData = userSnapshot.data!;

                return Column(
                  children: <Widget>[
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                width: double.infinity,
                                color: const Color(0xffD9D9D9),
                                child: topic['imageUrl'] != null
                                    ? Image.network(topic['imageUrl'], fit: BoxFit.cover)
                                    : Container(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    topic['title'] ?? 'No Title',
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xff327B90),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundImage: userData['profilePicture'] != null
                                            ? NetworkImage(userData['profilePicture'])
                                            : null,
                                        child: userData['profilePicture'] == null
                                            ? const Icon(Icons.person, size: 12, color: Colors.white)
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'by',
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xff6DD484),
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        userData['displayName'] ?? 'Unknown',
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xffB8E175),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
