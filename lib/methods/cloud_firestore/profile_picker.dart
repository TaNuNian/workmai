import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UploadProfile with ChangeNotifier {
  User? _user;
  Map<String, dynamic>? _userData;

  User? get user => _user;
  Map<String, dynamic>? get userData => _userData;

  UploadProfile() {
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
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
    if (_user != null) {
      try {
        print('Updating profile picture for user: ${_user!.uid}');
        print('Image URL: $imageUrl');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .update({'profile.profilePicture': imageUrl});

        print('Profile picture updated successfully: $imageUrl');
        if (_userData != null) {
          _userData!['profile']['profilePicture'] = imageUrl;
          notifyListeners();
        }
      } catch (e) {
        print('Error updating profile picture: $e');
      }
    } else {
      print('No user logged in.');
    }
  }

  Future<void> updateBackgroundPicture(String imageUrl) async {
    if (_user != null) {
      try {
        print('Updating background picture for user: ${_user!.uid}');
        print('Image URL: $imageUrl');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .update({'profile.backgroundPicture': imageUrl});

        print('Background picture updated successfully: $imageUrl');
        if (_userData != null) {
          _userData!['profile']['backgroundPicture'] = imageUrl;
          notifyListeners();
        }
      } catch (e) {
        print('Error updating background picture: $e');
      }
    } else {
      print('No user logged in.');
    }
  }
}