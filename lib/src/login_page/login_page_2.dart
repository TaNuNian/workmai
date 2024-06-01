import 'package:flutter/material.dart';
import 'package:workmai/src/login_page/login_page_widget/login_textbox.dart';

import 'login_page_widget/create_user.dart';
import 'login_page_widget/forgot_password.dart';
import 'login_page_widget/login_banner.dart';
import 'login_page_widget/login_textfield.dart';
import 'login_page_widget/signin_button.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const LoginBanner(),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.05, horizontal: width * 0.05),
              child: SizedBox(
                width: double.infinity,
                height: height * 0.6,
                // decoration: const BoxDecoration(
                //   color: Colors.black,
                // ),
                child: const Column(
                  children: [
                    LoginTextbox(
                        hint: 'อีเมลล์', obsec: false, type: 'อีเมลล์'),
                    LoginTextbox(
                        hint: 'รหัสผ่าน', obsec: true, type: 'รหัสผ่าน'),
                    SigninButton(),
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
            )
          ],
        ),
      ),
    );
  }
}
