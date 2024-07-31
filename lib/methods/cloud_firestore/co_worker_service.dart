import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmai/methods/cloud_firestore/chat.dart';

class CoWorkerService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // สร้าง array ชื่อ co-workers ใน document ของผู้ใช้
  Future<void> createCoWorkersArray() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentReference userRef =
      _firestore.collection('users').doc(user.uid);

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

  // ดึงข้อมูล co-workers ของผู้ใช้
  Future<List<Map<String, dynamic>>> fetchCoWorkers() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(user.uid).get();
      final List<dynamic> coWorkers = userDoc['co-workers'];

      List<Map<String, dynamic>> coWorkersData = [];
      for (String coWorkerId in coWorkers) {
        final DocumentSnapshot coWorkerDoc =
        await _firestore.collection('users').doc(coWorkerId).get();
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

  // ส่งคำขอ matching
  Future<void> sendMatchingRequest({
    required String groupName,
    required List<String> receiverIds,
    required String type,
    required String message,
    required String? chatId,
    String? profileImage,
    required String? mode,
  }) async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception('No authenticated user.');

    final Map<String, dynamic> matchingRequestData = {
      'senderId': currentUser.uid,
      'receiverIds': receiverIds,
      'acceptUserIds': [],
      'type': type,
      'groupName': groupName,
      'profileImage': profileImage ?? '',
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'rejectReasons': {},
      'chatId': chatId,
      'mode': mode,
      'statuses': receiverIds.asMap().map((_, id) => MapEntry(id, 'pending')),
    };

    final DocumentReference requestRef = await _firestore.collection('matchingRequest').add(matchingRequestData);
    final String requestId = requestRef.id;

    // เพิ่ม requestId ไปยัง document ของ sender
    await addMatchRequestId(userId: currentUser.uid, requestId: requestId, isSender: true);

    // เพิ่ม requestId ไปยัง document ของ receivers
    for (String receiverId in receiverIds) {
      await addMatchRequestId(userId: receiverId, requestId: requestId, isSender: false);
    }
  }

  // ยอมรับคำขอ matching
  Future<void> acceptMatchingRequest(String requestId, String userId) async {
    final DocumentReference requestRef =
    _firestore.collection('matchingRequest').doc(requestId);
    final request = await requestRef.get();
    final data = request.data() as Map<String, dynamic>;
    final chatId = data['chatId'];

    await requestRef.update({
      'acceptUserIds': FieldValue.arrayUnion([userId]),
      'receiverIds': FieldValue.arrayRemove([userId]),
      'statuses.$userId': 'accepted',
    });

    final DocumentSnapshot requestDoc = await requestRef.get();
    final String senderId = requestDoc['senderId'];

    // เพิ่ม senderId เข้าไปใน co-workers ของผู้ใช้
    final DocumentReference userRef = _firestore.collection('users').doc(userId);
    await userRef.update({
      'co-workers': FieldValue.arrayUnion([senderId]),
    });

    // เพิ่ม userId เข้าไปใน co-workers ของ sender
    final DocumentReference senderRef = _firestore.collection('users').doc(senderId);
    await senderRef.update({
      'co-workers': FieldValue.arrayUnion([userId]),
    });

    // เพิ่มผู้ใช้เข้าห้องแชท
    await ChatService().addChatToUser(chatId, userId, true);

    // เพิ่ม senderId เข้าไปใน co-workers ของผู้ใช้
    await addCoWorker(userId, senderId);

    // เพิ่ม userId เข้าไปใน co-workers ของ sender
    await addCoWorker(senderId, userId);

    // ลบ requestId ออกจาก receiverIds ของผู้ใช้
    await removeMatchRequestId(userId: userId, requestId: requestId, isSender: false);
  }

  // เพิ่มผู้ใช้ใน co-workers
  Future<void> addCoWorker(String userId, String coWorkerId) async {
    final DocumentReference userRef = _firestore.collection('users').doc(userId);
    await userRef.update({
      'co-workers': FieldValue.arrayUnion([coWorkerId]),
    });
  }

  // ปฏิเสธคำขอ matching พร้อมเหตุผล
  Future<void> rejectMatchingRequest(String requestId, String userId, String reason) async {
    final DocumentReference requestRef =
    _firestore.collection('matchingRequest').doc(requestId);

    await requestRef.update({
      'rejectReasons.$userId': reason,
      'receiverIds': FieldValue.arrayRemove([userId]),
      'statuses.$userId': 'rejected',
    });

    // ลบ requestId ออกจาก receiverIds ของผู้ใช้
    await removeMatchRequestId(userId: userId, requestId: requestId, isSender: false);
  }

  // เพิ่ม requestId ไปยัง document ของผู้ใช้
  Future<void> addMatchRequestId({
    required String userId,
    required String requestId,
    required bool isSender,
  }) async {
    final DocumentReference userRef = _firestore.collection('users').doc(userId);

    final field = isSender ? 'matchRequests.receiverId':'matchRequests.senderId' ;

    await userRef.update({
      field: FieldValue.arrayUnion([requestId]),
    });
  }

  // ลบ requestId ออกจาก document ของผู้ใช้
  Future<void> removeMatchRequestId({
    required String userId,
    required String requestId,
    required bool isSender,
  }) async {
    print(requestId);
    print(userId);
    final DocumentReference userRef = _firestore.collection('users').doc(userId);

    final field = isSender ? 'matchRequests.receiverId':'matchRequests.senderId';

    await userRef.update({
      field: FieldValue.arrayRemove([requestId]),
    });
  }
}
