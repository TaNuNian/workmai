import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(String? userID,
      String name,
      int age,
      Timestamp birthdate,
      List<String> interested_tags,
      List<String> skilled_tags,
      String? mbti,
      List<String>? active_time,
      String? work_style,
      String? aboutme) async {
    return _db.collection('users').doc(userID).set({
      'profile':{
        'name': name,
        'age': age,
        'birthdate': birthdate,
        'interested_tags': interested_tags,
        'skilled_tags': skilled_tags,
        'mbti': mbti ?? '',
        'active_time': active_time ?? [],
        'work_style': work_style ?? '',
        'aboutme': aboutme ?? '',
      }
    });
  }

  Future<void> updateUser(
      String? userID,
      String? name,
      int? age,
      Timestamp? birthdate,
      List<String>? interested_tags,
      List<String>? skilled_tags,
      String? mbti,
      String? active_time,
      String? work_style,
      String? aboutme) async {
    if (userID == null) {
      throw ArgumentError('userID is required');
    }

    Map<String, dynamic> updateData = {};

    if (name != null) updateData['profile.name'] = name;
    if (age != null) updateData['profile.age'] = age;
    if (birthdate != null) updateData['profile.birthdate'] = birthdate;
    if (interested_tags != null) updateData['profile.interested_tags'] = interested_tags;
    if (skilled_tags != null) updateData['profile.skilled_tags'] = skilled_tags;
    if (mbti != null) updateData['profile.mbti'] = mbti;
    if (active_time != null) updateData['profile.active_time'] = active_time;
    if (work_style != null) updateData['profile.work_style'] = work_style;
    if (aboutme != null) updateData['profile.aboutme'] = aboutme;

    return _db.collection('users').doc(userID).update(updateData);

  }
  Future<void> deleteUser(String userId) {
    return _db.collection('users').doc(userId).delete();
  }

  Stream<DocumentSnapshot> getUser(String userId) {
    return _db.collection('users').doc(userId).snapshots();
  }

  Stream<QuerySnapshot> getUsers() {
    return _db.collection('users').snapshots();
  }
}
