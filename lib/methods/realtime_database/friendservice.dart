// import 'package:firebase_database/firebase_database.dart';
//
// class FriendService {
//   final DatabaseReference _db = FirebaseDatabase.instance.ref();
//
//   // Method for adding a friend
//   Future<void> addFriend(String userId, String friendId) async {
//     try {
//       await _db.child('users').child(userId).child('friends').child(friendId).set(true);
//     } catch (e) {
//       print('Error adding friend: $e');
//     }
//   }
//
//   // Method for removing a friend
//   Future<void> removeFriend(String userId, String friendId) async {
//     try {
//       await _db.child('users').child(userId).child('friends').child(friendId).remove();
//     } catch (e) {
//       print('Error removing friend: $e');
//     }
//   }
//
//   // Method for getting a list of friends
//   Future<Map<String, dynamic>> getFriends(String userId) async {
//     try {
//       DataSnapshot snapshot = (await _db.child('users').child(userId).child('friends').once()) as DataSnapshot;
//       Map<String, dynamic> friends = (snapshot.value as Map<dynamic, dynamic>?)?.map((key, value) => MapEntry(key.toString(), value)) ?? {};
//       return friends;
//     } catch (e) {
//       print('Error getting friends: $e');
//       return {};
//     }
//   }
//
//   // Method for updating user's online status
//   Future<void> updateOnlineStatus(String userId, bool isOnline) async {
//     try {
//       await _db.child('users').child(userId).update({
//         'online': isOnline,
//         'lastSeen': DateTime.now().toIso8601String(),
//       });
//     } catch (e) {
//       print('Error updating online status: $e');
//     }
//   }
// }
