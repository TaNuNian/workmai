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
          'displayName': friendProfile['display_name'],
          'profilePicture': friendProfile['profilePicture'],
        });
      }
      return friendsData;
    }
    return [];
  }


  Future<Map<String, dynamic>?> fetchFriendData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return {
        'name': data['profile']['name'],
        'displayName': data['profile']['display_name'],
        'profilePicture': data['profile']['profilePicture'],
      };
    } catch (e) {
      print('Error fetching friend data: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    query = query.toLowerCase();
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      return [];
    }

    // Fetch current user's friends
    final DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
    final List<dynamic> friends = userDoc['friends'] ?? [];

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
        'displayName': profile['display_name'],
        'profilePicture': profile['profilePicture'],
      };
    }).where((user) => user['uid'] != currentUser.uid && !friends.contains(user['uid'])).toList();
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

  Future<void> createFriendsArray() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentReference userRef = _firestore.collection('users').doc(user.uid);

      try {
        await userRef.set({
          'friends': FieldValue.arrayUnion([]),
        }, SetOptions(merge: true));
      } catch (e) {
        throw Exception("Failed to create friends array: $e");
      }
    } else {
      throw Exception("User is not authenticated");
    }
  }


  Future<List<Map<String, dynamic>>> fetchFriendRequests() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      final List<dynamic> senderIds = userDoc['friendRequests']['senderId'] ?? [];

      List<Map<String, dynamic>> friendRequests = [];
      for (String senderId in senderIds) {
        final DocumentSnapshot senderDoc = await _firestore.collection('users').doc(senderId).get();
        final senderProfile = senderDoc['profile'];
        friendRequests.add({
          'uid': senderDoc.id,
          'name': senderProfile['name'],
          'displayName': senderProfile['display_name'],
          'profilePicture': senderProfile['profilePicture'],
        });
      }
      return friendRequests;
    }
    return [];
  }

  // ฟังก์ชันสำหรับส่งคำขอเป็นเพื่อน
  Future<void> sendFriendRequest(String receiverId) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final DocumentReference senderDoc = _firestore.collection('users').doc(currentUser.uid);
    final DocumentReference receiverDoc = _firestore.collection('users').doc(receiverId);

    try {
      await _firestore.runTransaction((transaction) async {
        final senderSnapshot = await transaction.get(senderDoc);
        final receiverSnapshot = await transaction.get(receiverDoc);

        if (!senderSnapshot.exists || !receiverSnapshot.exists) {
          print(senderSnapshot);

          throw Exception('User does not exist!');
        }
        transaction.update(senderDoc, {
          'friendRequests.receiverId': FieldValue.arrayUnion([receiverId])
        });
        transaction.update(receiverDoc, {
          'friendRequests.senderId': FieldValue.arrayUnion([currentUser.uid])
        });
      });
    } catch (e) {
      print('Transaction error: $e');
      throw e; // Rethrow the error for further handling
    }
  }

  // ฟังก์ชันสำหรับยอมรับคำขอเป็นเพื่อน
  Future<void> acceptFriendRequest(String senderId) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      final DocumentReference currentUserDoc = _firestore.collection('users').doc(currentUser.uid);
      final DocumentReference senderDoc = _firestore.collection('users').doc(senderId);

      // Add each other to friends array
      await currentUserDoc.update({
        'friends': FieldValue.arrayUnion([senderId]),
        'friendRequests.senderId': FieldValue.arrayRemove([senderId]),
      });

      await senderDoc.update({
        'friends': FieldValue.arrayUnion([currentUser.uid]),
        'friendRequests.receiverId': FieldValue.arrayRemove([currentUser.uid]),
      });
    }
  }
  // ฟังก์ชันสำหรับปฏิเสธคำขอเป็นเพื่อน
  Future<void> declineFriendRequest(String senderId) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      final DocumentReference currentUserDoc = _firestore.collection('users').doc(currentUser.uid);
      final DocumentReference senderDoc = _firestore.collection('users').doc(senderId);

      // Remove friend request
      await currentUserDoc.update({
        'friendRequests.senderId': FieldValue.arrayRemove([senderId]),
      });

      await senderDoc.update({
        'friendRequests.receiverId': FieldValue.arrayRemove([currentUser.uid]),
      });
    }
  }

  Future<void> createFriendRequests() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      await userDoc.set({
        'friendRequests': {
          'senderId': [],
          'receiverId': [],
        }
      }, SetOptions(merge: true));
    }
  }
}
