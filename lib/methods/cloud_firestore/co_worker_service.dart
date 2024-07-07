import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CoWorkerService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createCoWorkersArray() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentReference userRef = _firestore.collection('users').doc(user.uid);

      try {
        await userRef.set({
          'co-workers': FieldValue.arrayUnion([]),
        }, SetOptions(merge: true));
      } catch (e) {
        throw Exception("Failed to create co-workers array: $e");
      }
    } else {
      throw Exception("User is not authenticated");
    }
  }

  Future<List<Map<String, dynamic>>> fetchCoWorkers() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      final List<dynamic> coWorkers = userDoc['co-workers'];

      List<Map<String, dynamic>> coWorkersData = [];
      for (String coWorkerId in coWorkers) {
        final DocumentSnapshot coWorkerDoc = await _firestore.collection('users').doc(coWorkerId).get();
        final coWorkerProfile = coWorkerDoc['profile'];
        coWorkersData.add({
          'uid': coWorkerDoc.id,
          'name': coWorkerProfile['name'],
          'displayName': coWorkerProfile['display_name'],
          'profilePicture': coWorkerProfile['profilePicture'],
        });
      }
      return coWorkersData;
    }
    return [];
  }

}