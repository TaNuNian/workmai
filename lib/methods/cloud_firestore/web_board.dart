import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class WebboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addTopic(String title, String content, String userId, {String? imageUrl}) async {
    await _firestore.collection('webboard').add({
      'title': title,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
      'userId': userId,
      'likes': 0,
      'likedBy': [],
      'imageUrl': imageUrl,
    });
  }

  Future<void> addComment(String topicId, String message, String userId, {String? imageUrl}) async {
    await _firestore.collection('webboard').doc(topicId).collection('comments').add({
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'userId': userId,
      'likes': 0,
      'likedBy': [],
      'imageUrl': imageUrl,
      'replyTo': null,
    });
  }

  Future<void> addReply(String topicId, String commentId, String message, String userId, {String? imageUrl, String? replyTo}) async {
    await _firestore.collection('webboard').doc(topicId).collection('comments').doc(commentId).collection('replies').add({
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'userId': userId,
      'likes': 0,
      'likedBy': [],
      'imageUrl': imageUrl,
      'replyTo': replyTo,
    });
  }

  Future<void> toggleLikePost(String topicId, String userId) async {
    DocumentReference postRef = _firestore.collection('webboard').doc(topicId);
    DocumentSnapshot postSnapshot = await postRef.get();
    Map<String, dynamic> postData = postSnapshot.data() as Map<String, dynamic>;

    if ((postData['likedBy'] as List).contains(userId)) {
      postRef.update({
        'likes': FieldValue.increment(-1),
        'likedBy': FieldValue.arrayRemove([userId])
      });
    } else {
      postRef.update({
        'likes': FieldValue.increment(1),
        'likedBy': FieldValue.arrayUnion([userId])
      });
    }
  }

  Future<void> toggleLikeComment(String topicId, String commentId, String userId) async {
    DocumentReference commentRef = _firestore.collection('webboard').doc(topicId).collection('comments').doc(commentId);
    DocumentSnapshot commentSnapshot = await commentRef.get();
    Map<String, dynamic> commentData = commentSnapshot.data() as Map<String, dynamic>;

    if ((commentData['likedBy'] as List).contains(userId)) {
      commentRef.update({
        'likes': FieldValue.increment(-1),
        'likedBy': FieldValue.arrayRemove([userId])
      });
    } else {
      commentRef.update({
        'likes': FieldValue.increment(1),
        'likedBy': FieldValue.arrayUnion([userId])
      });
    }
  }

  Future<String?> uploadFile(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref().child('uploads/$fileName');
      UploadTask uploadTask = storageRef.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }
  Future<QuerySnapshot> getTopics() async {
    return await _firestore.collection('webboard').get();
  }
// Other methods...
}
