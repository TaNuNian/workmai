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

  Future<Map<String, dynamic>> getChatData(String chatId) async {
    final DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();
    return chatDoc.data() as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> fetchChats(bool isFriend) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final List<dynamic> chatIds = isFriend
            ? (userData['chats']['friendChats'] as List<dynamic>? ?? [])
            : (userData['chats']['coWorkerChats'] as List<dynamic>? ?? []);

        List<Map<String, dynamic>> chatData = [];

        for (String chatId in chatIds) {
          final DocumentSnapshot chatDoc = await _firestore
              .collection('chats')
              .doc(chatId)
              .get();

          if (chatDoc.exists) {
            final data = chatDoc.data() as Map<String, dynamic>?;

            if (data != null) {
              chatData.add({
                'chatId': chatDoc.id,
                'chatType': data['chatType'] ?? '',
                'groupName': data.containsKey('groupName') ? data['groupName'] : '',
                'groupProfileImage': data.containsKey('groupProfileImage') ? data['groupProfileImage'] : '',
                'lastMessage': data['lastMessage'] ?? {},
                'members': data['members'] ?? [],
              });
            }
          }
        }
        return chatData;
      }
    }
    return [];
  }

  Future<List<DocumentSnapshot>> fetchGroupChats(bool isFriend) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final List<dynamic> chatIds = isFriend
            ? (userData['chats']['friendChats'] as List<dynamic>? ?? [])
            : (userData['chats']['coWorkerChats'] as List<dynamic>? ?? []);

        List<DocumentSnapshot> groupChats = [];

        for (String chatId in chatIds) {
          final DocumentSnapshot chatDoc = await _firestore
              .collection('chats')
              .doc(chatId)
              .get();

          if (chatDoc.exists) {
            final data = chatDoc.data() as Map<String, dynamic>?;

            if (data != null && data['chatType'] == 'group') {
              groupChats.add(chatDoc);
            }
          }
        }
        return groupChats;
      }
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

  Future<void> addChatToUser(String chatId, String userId, bool isFriend) async {
    final DocumentReference userRef = _firestore.collection('users').doc(userId);
    final DocumentSnapshot userDoc = await userRef.get();

    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

    if (userData == null) {
      userData = {'chats': {'friendChats': [], 'coWorkerChats': []}};
    } else if (userData['chats'] == null) {
      userData['chats'] = {'friendChats': [], 'coWorkerChats': []};
    } else {
      if (userData['chats']['friendChats'] == null) {
        userData['chats']['friendChats'] = [];
      }
      if (userData['chats']['coWorkerChats'] == null) {
        userData['chats']['coWorkerChats'] = [];
      }
    }

    if (isFriend) {
      if (!userData['chats']['friendChats'].contains(chatId)) {
        userData['chats']['friendChats'].add(chatId);
      }
    } else {
      if (!userData['chats']['coWorkerChats'].contains(chatId)) {
        userData['chats']['coWorkerChats'].add(chatId);
      }
    }

    await userRef.update({'chats': userData['chats']});
  }
}
