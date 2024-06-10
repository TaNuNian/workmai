import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String? name;
  int? age;
  DateTime? birthdate;
  List<String>? interested_tags;
  List<String>? skilled_tags;
  String? mbti;
  String? active_time;
  String? work_style;
  String? aboutme;

  Profile({
    this.name,
    this.age,
    this.birthdate,
    this.interested_tags,
    this.skilled_tags,
    this.mbti,
    this.active_time,
    this.work_style,
    this.aboutme,
  });
}
