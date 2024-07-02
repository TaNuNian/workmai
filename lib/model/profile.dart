class Profile {
  String? display_name;
  String? name;
  String? nameLowerCase;
  String? gender;
  int? age;
  DateTime? birthdate;
  List<String>? interested_tags;
  List<String>? skilled_tags;
  String? mbti;
  List<String>? active_time;
  String? work_style;
  String? aboutme;

  Profile({
    this.display_name,
    this.name,
    this.nameLowerCase,
    this.gender,
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
