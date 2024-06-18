import 'package:flutter/material.dart';
import 'package:workmai/model/profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile _profile = Profile();

  Profile get profile => _profile;
  void setName(String name) {
    _profile.name = name;
    notifyListeners();
  }

  void setBirthdate(DateTime birthdate) {
    _profile.birthdate = birthdate;
    notifyListeners();
  }
  void updateProfile(Profile newProfile) {
    _profile = newProfile;
    notifyListeners();
  }

  void updateInterestedTags(List<String> tags) {
    _profile.interested_tags = tags;
    notifyListeners();
  }

  void updateSkilledTags(List<String> tags) {
    _profile.skilled_tags = tags;
    notifyListeners();
  }

  void updateName(String name) {
    _profile.name = name;
    notifyListeners();
  }

  void updateBirthdate(DateTime birthdate) {
    _profile.birthdate = birthdate;
    notifyListeners();
  }

// Add more update methods as needed
}
