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
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .get();
        _userData = userDoc.data() as Map<String, dynamic>;
        notifyListeners();
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  Future<void> updateProfilePicture(String imageUrl) async {
    print('Updating profile picture for user: ${_user!.uid}');
    if (_user != null) {
      try {
        print('Image URL: $imageUrl');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .update({'profile.profilePicture': imageUrl});

        print('Profile picture updated successfully: $imageUrl');
        _userData?['profile']['profilePicture'] = imageUrl;
        notifyListeners();
      } catch (e) {
        print('Error updating profile picture: $e');
      }
    } else {
      print('No user logged in.');
    }
  }
}
