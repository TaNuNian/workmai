import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> fetchUserProfile(String uid) async {
    try {
      final DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final profile = userDoc['profile'];
        return {
          'uid': userDoc.id,
          'name': profile['name'],
          'displayName': profile['displayName'],
          'profilePicture': profile['profilePicture'],
          'backgroundPicture': profile['backgroundPicture'],
          'interested_tags': profile['interested_tags'],
          'skilled_tags': profile['skilled_tags'],
          'birthdate': profile['birthdate'],
          'age': profile['age'],
          'mbti': profile['mbti'],
          'work_style': profile['work_style'],
          'active_time': profile['active_time'],
          'aboutme': profile['aboutme'],
        };
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    return null;
  }
}
