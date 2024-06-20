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
    setAge(calculateAge(birthdate));
  }

  void setAge(int age) {
    _profile.age = age;
    notifyListeners();
  }

  void setSkilledTags(List<String> tags) {
    _profile.skilled_tags = tags;
    notifyListeners();
  }

  void setInterestedTags(List<String> tags) {
    _profile.interested_tags = tags;
    notifyListeners();
  }

  void setAboutme(String aboutme) {
    _profile.aboutme = aboutme;
    notifyListeners();
  }
  void setActive_Time(List<String> active_time) {
    _profile.active_time = active_time;
    notifyListeners();
  }
  void setMBTI(String mbti) {
    _profile.mbti = mbti;
    notifyListeners();
  }
  void setWStyle(String wstyle) {
    _profile.work_style = wstyle;
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
    setAge(calculateAge(birthdate));
  }

  // ฟังก์ชันสำหรับคำนวณอายุ
  int calculateAge(DateTime birthdate) {
    DateTime today = DateTime.now();
    int age = today.year - birthdate.year;
    if (today.month < birthdate.month ||
        (today.month == birthdate.month && today.day < birthdate.day)) {
      age--;
    }
    return age;
  }
}
