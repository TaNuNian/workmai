import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    await requestRef.update({
      'acceptUserIds': FieldValue.arrayUnion([userId]),
      'receiverIds': FieldValue.arrayRemove([userId]),
    });

    // ลบ requestId ออกจาก receiverIds ของผู้ใช้
    await removeMatchRequestId(userId: userId, requestId: requestId, isSender: false);
  }

  // ปฏิเสธคำขอ matching พร้อมเหตุผล
  Future<void> rejectMatchingRequest(String requestId, String userId, String reason) async {
    final DocumentReference requestRef =
    _firestore.collection('matchingRequest').doc(requestId);

    await requestRef.update({
      'rejectReasons.$userId': reason,
      'receiverIds': FieldValue.arrayRemove([userId]),
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

    final field = isSender ? 'matchRequests.senderIds' : 'matchRequests.receiverIds';

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
    final DocumentReference userRef = _firestore.collection('users').doc(userId);

    final field = isSender ? 'matchRequests.senderIds' : 'matchRequests.receiverIds';

    await userRef.update({
      field: FieldValue.arrayRemove([requestId]),
    });
  }
}
