import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _autoLogin(context);
  }

  Future<void> _autoLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if (email != null && password != null) {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushReplacementNamed(context, '/bottomnav');
      } catch (e) {
        Navigator.pushReplacementNamed(context, '/login2');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login2');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}