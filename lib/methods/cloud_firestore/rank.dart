import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmai/src/decor/colors.dart';

class RankService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ฟังก์ชั่นสร้าง Rank สำหรับผู้ใช้ที่พึ่งลงทะเบียนใหม่
  Future<void> createInitialRank(String userId) async {
    try {
      await _firestore.collection('ranks').doc(userId).set({
        'rankName': 'Unranked',
        'points': 0,
        'rankHistory': [],
      });
      print('Initial rank created for user $userId');
    } catch (e) {
      print('Error creating initial rank: $e');
    }
  }

  // Get user rank data
  Future<DocumentSnapshot> getUserRank(String userId) async {
    print('Fetching rank for user $userId');
    DocumentSnapshot snapshot = await _firestore.collection('ranks').doc(userId).get();
    print('User Rank Data: ${snapshot.data()}'); // ตรวจสอบข้อมูลที่ได้
    return snapshot;
  }

  // Update user rank data
  Future<void> updateUserRank(String userId, int points, String reason) async {
    DocumentReference rankRef = _firestore.collection('ranks').doc(userId);
    DocumentSnapshot rankSnapshot = await rankRef.get();

    if (!rankSnapshot.exists) {
      await rankRef.set({
        'rankName': 'Unranked',
        'rankIcon': 'Icons.military_tech_outlined',
        'points': points,
        'rankHistory': [
          {
            'date': FieldValue.serverTimestamp(),
            'change': points,
            'reason': reason
          }
        ]
      });
    } else {
      int currentPoints = rankSnapshot['points'];
      String currentRankName = rankSnapshot['rankName'];
      String newRankName = currentRankName;

      // Update points
      currentPoints += points;

      // Check for rank update and reset points
      if (currentRankName == 'Unranked' && currentPoints >= 60) {
        newRankName = 'Beginner';
        currentPoints = 0;
      } else if (currentRankName == 'Beginner' && currentPoints >= 350) {
        newRankName = 'Intermediate';
        currentPoints = 0;
      } else if (currentRankName == 'Intermediate' && currentPoints >= 900) {
        newRankName = 'Expert';
        currentPoints = 0;
      }

      await rankRef.update({
        'rankName': newRankName,
        'points': currentPoints,
        'rankHistory': FieldValue.arrayUnion([
          {
            'date': FieldValue.serverTimestamp(),
            'change': points,
            'reason': reason
          }
        ])
      });
    }
  }

  // Get user rank history
  Future<QuerySnapshot> getUserRankHistory(String userId) async {
    return await _firestore.collection('ranks').doc(userId).collection('rankHistory').get();
  }
}