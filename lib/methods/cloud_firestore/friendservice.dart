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
      final DocumentReference friendRequestsRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('friendRequests')
          .doc('requests');

      final DocumentSnapshot friendRequestsDoc = await friendRequestsRef.get();

      if (friendRequestsDoc.exists) {
        final List<dynamic> senderIds = friendRequestsDoc['receiverId'];

        List<Map<String, dynamic>> friendRequestsData = [];
        for (String senderId in senderIds) {
          final DocumentSnapshot senderDoc = await _firestore.collection('users').doc(senderId).get();
          final senderProfile = senderDoc['profile'];
          friendRequestsData.add({
            'uid': senderDoc.id,
            'name': senderProfile['name'],
            'displayName': senderProfile['displayName'],
            'profilePicture': senderProfile['profilePicture'],
          });
        }
        return friendRequestsData;
      } else {
        return [];
      }
    } else {
      throw Exception("User is not authenticated");
    }
  }

  // ฟังก์ชันสำหรับส่งคำขอเป็นเพื่อน
  Future<void> sendFriendRequest(String receiverId) async {
    final User? sender = _auth.currentUser;
    if (sender != null) {
      final DocumentReference receiverRequestRef = _firestore
          .collection('users')
          .doc(receiverId)
          .collection('friendRequests')
          .doc('requests');

      final DocumentReference senderRequestRef = _firestore
          .collection('users')
          .doc(sender.uid)
          .collection('friendRequests')
          .doc('requests');

      try {
        await _firestore.runTransaction((transaction) async {
          transaction.update(receiverRequestRef, {
            'receiverId': FieldValue.arrayUnion([sender.uid])
          });
          transaction.update(senderRequestRef, {
            'senderId': FieldValue.arrayUnion([receiverId])
          });
        });
      } catch (e) {
        throw Exception("Failed to send friend request: $e");
      }
    } else {
      throw Exception("User is not authenticated");
    }
  }


  // ฟังก์ชันสำหรับยอมรับคำขอเป็นเพื่อน
  Future<void> acceptFriendRequest(String senderId) async {
    final User? receiver = _auth.currentUser;
    if (receiver != null) {
      final DocumentReference receiverRef = _firestore.collection('users').doc(receiver.uid);
      final DocumentReference senderRef = _firestore.collection('users').doc(senderId);

      final DocumentReference receiverRequestRef = _firestore
          .collection('users')
          .doc(receiver.uid)
          .collection('friendRequests')
          .doc('requests');

      final DocumentReference senderRequestRef = _firestore
          .collection('users')
          .doc(senderId)
          .collection('friendRequests')
          .doc('requests');

      try {
        await _firestore.runTransaction((transaction) async {
          transaction.update(receiverRef, {
            'friends': FieldValue.arrayUnion([senderId])
          });
          transaction.update(senderRef, {
            'friends': FieldValue.arrayUnion([receiver.uid])
          });
          transaction.update(receiverRequestRef, {
            'receiverId': FieldValue.arrayRemove([senderId])
          });
          transaction.update(senderRequestRef, {
            'senderId': FieldValue.arrayRemove([receiver.uid])
          });
        });
      } catch (e) {
        throw Exception("Failed to accept friend request: $e");
      }
    } else {
      throw Exception("User is not authenticated");
    }
  }

  // ฟังก์ชันสำหรับปฏิเสธคำขอเป็นเพื่อน
  Future<void> declineFriendRequest(String senderId) async {
    final User? receiver = _auth.currentUser;
    if (receiver != null) {
      final DocumentReference receiverRequestRef = _firestore
          .collection('users')
          .doc(receiver.uid)
          .collection('friendRequests')
          .doc('requests');

      final DocumentReference senderRequestRef = _firestore
          .collection('users')
          .doc(senderId)
          .collection('friendRequests')
          .doc('requests');

      try {
        await _firestore.runTransaction((transaction) async {
          transaction.update(receiverRequestRef, {
            'receiverId': FieldValue.arrayRemove([senderId])
          });
          transaction.update(senderRequestRef, {
            'senderId': FieldValue.arrayRemove([receiver.uid])
          });
        });
      } catch (e) {
        throw Exception("Failed to decline friend request: $e");
      }
    } else {
      throw Exception("User is not authenticated");
    }
  }

  Future<void> createFriendRequestsDocument() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentReference friendRequestsRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('friendRequests')
          .doc('requests');

      try {
        await friendRequestsRef.set({
          'senderId': [],
          'receiverId': [],
        });
      } catch (e) {
        throw Exception("Failed to create friend requests document: $e");
      }
    } else {
      throw Exception("User is not authenticated");
    }
  }
}
