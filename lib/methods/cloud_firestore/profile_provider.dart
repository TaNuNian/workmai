import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UploadProfile with ChangeNotifier {
  User? _user;
  Map<String, dynamic>? _userData;

  User? get user => _user;
  Map<String, dynamic>? get userData => _userData;

  Future<void> fetchUserData() async {
    _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();

      _userData = userDoc.data() as Map<String, dynamic>;
      notifyListeners();
    }
  }

  Future<void> updateProfilePicture(String imageUrl) async {
    if (_user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .update({'profile.profilePicture': imageUrl});
      _userData?['profile']['profilePicture'] = imageUrl;
      notifyListeners();
    }
  }
}
