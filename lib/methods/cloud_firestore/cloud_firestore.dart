import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(
    String? userID,
    String displayName,
    String name,
    String nameLowerCase,
    String gender,
    int age,
    Timestamp birthdate,
    List<String> interestedTags,
    List<String> skilledTags,
    String? mbti,
    List<String>? activeTime,
    String? workStyle,
    String? aboutme,
    String? profilePicture,
    String? backgroundPicture,
  ) async {
    return _db.collection('users').doc(userID).set({
      'profile': {
        'display_name': displayName,
        'gender': gender,
        'name': name,
        'name_lower_case': nameLowerCase,
        'age': age,
        'birthdate': birthdate,
        'interested_tags': interestedTags,
        'skilled_tags': skilledTags,
        'mbti': mbti ?? '',
        'active_time': activeTime ?? [],
        'work_style': workStyle ?? '',
        'aboutme': aboutme ?? '',
        'profilePicture': profilePicture ?? '',
        'backgroundPicture': backgroundPicture ?? '',
      }
    });
  }

  Future<void> updateUser(
      String? userID,
      String? displayName,
      String? gender,
      String? name,
      String? nameLowerCase,
      int? age,
      Timestamp? birthdate,
      List<String>? interestedTags,
      List<String>? skilledTags,
      String? mbti,
      String? activeTime,
      String? workStyle,
      String? aboutme,
      String? profilePicture,
      String? backgroundPicture,) async {
    if (userID == null) {
      throw ArgumentError('userID is required');
    }

    Map<String, dynamic> updateData = {};

    if (name != null) updateData['profile.name'] = name;
    if (nameLowerCase != null)
      updateData['profile.name_lower_case'] = nameLowerCase;
    if (displayName != null) updateData['profile.display_name'] = displayName;
    if (gender != null) updateData['profile.gender'] = gender;
    if (age != null) updateData['profile.age'] = age;
    if (birthdate != null) updateData['profile.birthdate'] = birthdate;
    if (interestedTags != null)
      updateData['profile.interested_tags'] = interestedTags;
    if (skilledTags != null) updateData['profile.skilled_tags'] = skilledTags;
    if (mbti != null) updateData['profile.mbti'] = mbti;
    if (activeTime != null) updateData['profile.active_time'] = activeTime;
    if (workStyle != null) updateData['profile.work_style'] = workStyle;
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
