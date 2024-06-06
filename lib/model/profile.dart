import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String name;
  int age;
  Timestamp birthdate;
  List<String> interested_tags;
  List<String> skilled_tags;
  String? mbti;
  String? active_time;
  String? work_style;
  String? aboutme;

  Profile({
    required this.name,
    required this.age,
    required this.birthdate,
    required this.interested_tags,
    required this.skilled_tags,
    this.mbti,
    this.active_time,
    this.work_style,
    this.aboutme,
  });
}
