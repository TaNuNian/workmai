import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageUploader {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<File?> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return null;
  }

  Future<String?> uploadWebBoardImage(File image) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print('No user logged in');
        return null;
      }

      String uid = user.uid;
      String fileName = 'webboard_pictures/$uid/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = _storage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }


  Future<String?> uploadProfileImage(File image) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print('No user logged in');
        return null;
      }

      String uid = user.uid;
      String fileName = 'profile_pictures/$uid/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = _storage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<String?> uploadBackgroundImage(File image) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print('No user logged in');
        return null;
      }

      String uid = user.uid;
      String fileName = 'background_pictures/$uid/background_picture.jpg';
      Reference ref = _storage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<String?> uploadGroupProfileImage(File image) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print('No user logged in');
        return null;
      }

      String uid = user.uid;
      String fileName = 'group_profile_pictures/$uid/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = _storage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
