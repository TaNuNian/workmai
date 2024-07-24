import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createChatOrGetChatId(String userId1, String userId2, bool Isfriend) async {
    final CollectionReference chatsRef = _firestore.collection('chats');
    final QuerySnapshot existingChat = await chatsRef
        .where('members', arrayContains: userId1)
        .get();

    for (var doc in existingChat.docs) {
      List members = doc['members'];
      if (members.contains(userId2)) {
        return doc.id;
      }
    }

    DocumentReference newChat = await chatsRef.add({
      'members': [userId1, userId2],
      'lastMessage': {
        'text': '',
        'senderId': '',
        'timestamp': FieldValue.serverTimestamp(),
      },
      'chatType': 'private',
      'mode': Isfriend ? 'friend': 'co-worker'
      // 4 types: friend-private, friend-group, co-worker-private, co-worker-group
    });
    return newChat.id;
  }

  Future<void> sendMessage(String chatId, String text) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final DocumentReference messageDoc = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    final messageData = {
      'senderId': currentUser.uid,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await messageDoc.set(messageData);
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Stream<QuerySnapshot> getChatListStream(String userId) {
    return _firestore
        .collection('chats')
        .where('members', arrayContains: userId)
        .snapshots();
  }

  Stream<QuerySnapshot> getMessagesStream(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  Future<List<Map<String, dynamic>>> fetchChats(String chatType, String mode) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final QuerySnapshot chatSnapshot = await _firestore
          .collection('chats')
          .where('chatType', isEqualTo: chatType)
          .where('mode', isEqualTo: mode)
          .where('members', arrayContains: user.uid)
          .get();

      List<Map<String, dynamic>> chatData = [];
      for (QueryDocumentSnapshot chatDoc in chatSnapshot.docs) {
        chatData.add({
          'chatId': chatDoc.id,
          'chatType': chatDoc['chatType'],
          'groupName': chatDoc['groupName'] ?? '',
          'groupProfileImage': chatDoc['groupProfileImage'] ?? '',
          'lastMessage': chatDoc['lastMessage'],
          'members': chatDoc['members'],
        });
      }
      return chatData;
    }
    return [];
  }
  // ฟังก์ชันสำหรับสร้างห้องแชทกลุ่ม
  Future<String> createGroupChat(String groupName, List<String> memberIds, bool isFriend, {String? profileImageUrl}) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }

    memberIds.add(currentUser.uid);

    DocumentReference newGroupChat = await _firestore.collection('chats').add({
      'members': memberIds,
      'groupName': groupName,
      'groupProfileImage': profileImageUrl ?? '',
      'lastMessage': {
        'text': '',
        'senderId': '',
        'timestamp': FieldValue.serverTimestamp(),
      },
      'chatType': 'group',
      'mode': isFriend ? 'friend' : 'co-worker',
    });
    return newGroupChat.id;
  }
}
