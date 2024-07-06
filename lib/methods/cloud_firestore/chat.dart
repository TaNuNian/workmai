import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createChat(String userId1, String userId2) async {
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
    });

    return newChat.id;
  }

  Future<void> sendMessage(String chatId, String text) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final DocumentReference chatRef = _firestore.collection('chats').doc(chatId);
    final CollectionReference messagesRef = chatRef.collection('messages');

    final messageData = {
      'text': text,
      'senderId': currentUser.uid,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await messagesRef.add(messageData);

    await chatRef.update({
      'lastMessage': messageData,
    });
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
}