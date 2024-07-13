import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(String uid) async {
    final DocumentReference reviewDoc = _firestore.collection('reviews').doc(uid);
    final CollectionReference commentsCollection = reviewDoc.collection('comments');
    await _firestore.runTransaction((transaction) async {
      // Create review document
      transaction.set(reviewDoc, {
        'totalRating': 0.0,
        'reviewCount': 0,
      });
    });
  }

  Future<void> addReview(String reviewedUserId, double rating, String comment) async {
    final DocumentReference reviewDoc = _firestore.collection('reviews').doc(reviewedUserId);
    final CollectionReference commentsCollection = reviewDoc.collection('comments');

    await _firestore.runTransaction((transaction) async {
      final DocumentSnapshot snapshot = await transaction.get(reviewDoc);

      if (!snapshot.exists) {
        // If the document does not exist, create it
        transaction.set(reviewDoc, {
          'totalRating': rating,
          'reviewCount': 1,
        });
      } else {
        double totalRating = snapshot.get('totalRating');
        int reviewCount = snapshot.get('reviewCount');

        totalRating += rating;
        reviewCount += 1;

        transaction.update(reviewDoc, {
          'totalRating': totalRating,
          'reviewCount': reviewCount,
        });
      }

      transaction.set(commentsCollection.doc(), {
        'comment': comment,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<double> getAverageRating(String reviewedUserId) async {
    final DocumentSnapshot snapshot = await _firestore.collection('reviews').doc(reviewedUserId).get();

    if (snapshot.exists) {
      double totalRating = snapshot.get('totalRating');
      int reviewCount = snapshot.get('reviewCount');

      if (reviewCount > 0) {
        return totalRating / reviewCount;
      }
    }

    return 0.0; // Default rating if no reviews are present
  }

}