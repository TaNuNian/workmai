import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmai/methods/cloud_firestore/web_board.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';

class CommentModal extends StatefulWidget {
  final String webboardId;

  const CommentModal({Key? key, required this.webboardId}) : super(key: key);

  @override
  _CommentModalState createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal> {
  final WebboardService _webboardService = WebboardService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _commentController = TextEditingController();

  User? get user => _auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Comments',
            style: GoogleFonts.raleway(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('webboard')
                  .doc(widget.webboardId)
                  .collection('comments')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No comments available.'));
                }

                final comments = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index].data() as Map<String, dynamic>;
                    final commentId = comments[index].id;
                    bool isLiked = (comment['likedBy'] as List).contains(user!.uid);
                    int likeCount = comment['likes'] ?? 0;

                    return FutureBuilder<Map<String, dynamic>?>(
                      future: FriendService().fetchFriendData(comment['userId']),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (userSnapshot.hasError || !userSnapshot.hasData) {
                          return const Center(child: Text('Error loading user data'));
                        }

                        final userData = userSnapshot.data!;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: userData['profilePicture'] != null
                                ? NetworkImage(userData['profilePicture'])
                                : null,
                            child: userData['profilePicture'] == null
                                ? const Icon(Icons.person, color: Colors.white)
                                : null,
                          ),
                          title: Text(userData['displayName'] ?? 'Unknown'),
                          subtitle: Text(comment['message'] ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.thumb_up,
                                  color: isLiked ? Colors.blue : Colors.grey,
                                ),
                                onPressed: () async {
                                  await _webboardService.toggleLikeComment(widget.webboardId, commentId, user!.uid);
                                  setState(() {
                                    isLiked = !isLiked;
                                    likeCount += isLiked ? 1 : -1;
                                  });
                                },
                              ),
                              Text('$likeCount'),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              labelText: 'Add a comment',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                _webboardService.addComment(widget.webboardId, value, user!.uid);
                _commentController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}