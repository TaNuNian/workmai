import 'package:flutter/material.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/login_textbox.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/signin_button.dart';

import '../../../model/account.dart';
import 'login_page_widget/create_user.dart';
import 'login_page_widget/forgot_password.dart';
import 'login_page_widget/login_banner.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  _LoginPage2State createState() {
    return _LoginPage2State();
  }
}

class _LoginPage2State extends State<LoginPage2> {
  final _formKey = GlobalKey<FormState>();
  Account account = Account(email: '', password: '');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
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
                  // decoration: const BoxDecoration(
                  //   color: Colors.black,
                  // ),
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
                        SigninButton(account: account, formKey: _formKey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ForgotPassword(),
                            CreateUser(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
