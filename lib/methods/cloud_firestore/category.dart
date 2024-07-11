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

  Future<List<Map<String, dynamic>>> fetchCategoriesWithUserData() async {
    List<Map<String, dynamic>> categoriesWithUserData = [];
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('category').doc('tags').get();
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        Set<String> uniqueUids = {};
        if (data['interested'] != null) {
          uniqueUids.addAll(data['interested'].values.expand((uids) => List<String>.from(uids)).toSet());
        }
        if (data['skilled'] != null) {
          uniqueUids.addAll(data['skilled'].values.expand((uids) => List<String>.from(uids)).toSet());
        }

        for (String uid in uniqueUids) {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
          if (userDoc.exists) {
            Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
            categoriesWithUserData.add({
              'uid': uid,
              'name': userData['profile']['name'],
              'displayName': userData['profile']['display_name'],
              'profilePicture': userData['profile']['profilePicture'],
              'aboutme': userData['profile']['aboutme'],
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching categories with user data: $e');
    }
    return categoriesWithUserData;
  }}
