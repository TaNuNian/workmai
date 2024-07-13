import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategory {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> categoryInterested(String userID, List<String> interestedTags) async {
    try {
      DocumentSnapshot docSnapshot = await _db.collection('category').doc('tags').get();
      WriteBatch batch = _db.batch();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        for (String tag in interestedTags) {
          if (data['interested'] != null && (data['interested'] as Map<String, dynamic>).containsKey(tag)) {
            // Update existing tag array
            DocumentReference docRef = _db.collection('category').doc('tags');
            batch.update(docRef, {
              'interested.$tag': FieldValue.arrayUnion([userID]),
            });
            print('Added $userID to interested tag $tag');
          }
        }
      }
      await batch.commit();
      print('Batch update committed');
    } catch (error) {
      print('Failed to update document: $error');
    }
  }

  Future<void> categorySkilled(String userID, List<String> skilledTags) async {
    try {
      DocumentSnapshot docSnapshot = await _db.collection('category').doc('tags').get();
      WriteBatch batch = _db.batch();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        for (String tag in skilledTags) {
          String skilledTag = 'skilled.$tag';
          if (data['skilled'] != null && (data['skilled'] as Map<String, dynamic>).containsKey(tag)) {
            // Update existing skilled tag array
            DocumentReference docRef = _db.collection('category').doc('tags');
            batch.update(docRef, {
              'skilled.$tag': FieldValue.arrayUnion([userID]),
            });
            print('Added $userID to skilled tag $tag');
          }
        }
      }
      await batch.commit();
      print('Batch update committed');
    } catch (error) {
      print('Failed to update document: $error');
    }
  }
}
