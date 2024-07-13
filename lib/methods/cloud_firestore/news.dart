import 'package:cloud_firestore/cloud_firestore.dart';

class NewsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getNews(String category, String type) async {
    return await _firestore
        .collection('news')
        .doc(category)
        .collection(type)
        .get();
  }

  Future<void> updateNews(String category, String type, String newsId, String title, String content, {String? imageUrl}) async {
    await _firestore.collection('news').doc(category).collection(type).doc(newsId).update({
      'title': title,
      'content': content,
      'imageUrl': imageUrl ?? '',
    });
  }
}