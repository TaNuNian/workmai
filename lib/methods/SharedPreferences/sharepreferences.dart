import 'package:shared_preferences/shared_preferences.dart';

// ฟังก์ชันสำหรับบันทึกข้อมูลการล็อกอิน
Future<void> saveLoginDetails(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
  await prefs.setString('password', password);
}

// ฟังก์ชันสำหรับดึงข้อมูลการล็อกอิน
Future<Map<String, String?>> getLoginDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');
  String? password = prefs.getString('password');
  return {'email': email, 'password': password};
}

// ฟังก์ชันสำหรับลบข้อมูลการล็อกอิน
Future<void> clearLoginDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('email');
  await prefs.remove('password');
}
