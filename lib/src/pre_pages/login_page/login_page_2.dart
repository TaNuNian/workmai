import 'package:flutter/material.dart';
import 'package:workmai/model/account.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/create_user.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/forgot_password.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/login_banner.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/login_profile.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/login_textbox.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final _formKey = GlobalKey<FormState>();
  Account account = loginAccount;
  bool rememberMe = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadLoginDetails();
  }

  Future<void> _loadLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      setState(() {
        account.email = email;
        account.password = password;
        rememberMe = true;
      });
    }
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      if (rememberMe) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', account.email);
        await prefs.setString('password', account.password);
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('email');
        await prefs.remove('password');
      }
      try {
        await _auth.signInWithEmailAndPassword(email: account.email, password: account.password);
        Navigator.pushReplacementNamed(context, '/bottomnav');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const LoginBanner(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.05,
                    horizontal: width * 0.1,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: height * 0.6,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LoginTextbox(
                            hint: 'อีเมล',
                            obsec: false,
                            type: 'อีเมล',
                            account: account,
                          ),
                          LoginTextbox(
                            hint: 'รหัสผ่าน',
                            obsec: true,
                            type: 'รหัสผ่าน',
                            account: account,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                },
                              ),
                              Text('Remember me'),
                            ],
                          ),
                          SigninButton(account: account, formKey: _formKey, onSignIn: _handleSignIn),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ForgotPassword(),
                              CreateUser(formKey: _formKey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
