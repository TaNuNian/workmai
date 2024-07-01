import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchFriends() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      final List<dynamic> friends = userDoc['friends'];

      List<Map<String, dynamic>> friendsData = [];
      for (String friendId in friends) {
        final DocumentSnapshot friendDoc = await _firestore.collection('users').doc(friendId).get();
        final friendProfile = friendDoc['profile'];
        friendsData.add({
          'uid': friendDoc.id,
          'name': friendProfile['name'],
          'displayName': friendProfile['displayName'],
          'profilePicture': friendProfile['profilePicture'],
          // 'status': friendProfile['status'],
          // 'bio': friendProfile['bio'],
        });
      }
      return friendsData;
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    query = query.toLowerCase();
    final QuerySnapshot result = await _firestore
        .collection('users')
        .where('profile.name_lower_case', isGreaterThanOrEqualTo: query)
        .where('profile.name_lower_case', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    return result.docs.map((doc) {
      final profile = doc['profile'];
      return {
        'uid': doc.id,
        'name': profile['name'],
        'displayName': profile['displayName'],
        'profilePicture': profile['profilePicture'],
      };
    }).toList();
  }

  Future<void> addFriend(String friendId) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentReference userRef = _firestore.collection('users').doc(user.uid);
      await userRef.update({
        'friends': FieldValue.arrayUnion([friendId])
      });
    }
  }

  Future<void> removeFriend(String friendId) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentReference userRef = _firestore.collection('users').doc(user.uid);
      await userRef.update({
        'friends': FieldValue.arrayRemove([friendId])
      });
    }
  }
}
