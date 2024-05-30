import 'package:flutter/material.dart';
import 'package:workmai/routes.dart';

import 'login_page_widget/login_banner.dart';
import 'login_page_widget/login_textbox.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Banner
            LoginBanner(),

            // Body
            Flexible(
              // flex: 7,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  // color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Spacer(
                      //   flex: 1,
                      // ),
                      LoginTextbox(
                        hint: 'อีเมลล์',
                        obsec: false,
                      ),
                      // Spacer(
                      //   flex: 1,
                      // ),
                      LoginTextbox(
                        hint: 'รหัสผ่าน',
                        obsec: true,
                      ),
                      // Spacer(
                      //   flex: 1,
                      // ),

                      FilledButton(
                        onPressed: () {},
                        style: ButtonStyle(),
                        child: const Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text('ลืมรหัสผ่าน'),
                              ),
                              FilledButton(
                                onPressed: () {},
                                style: ButtonStyle(),
                                child: const Text(
                                  'สร้างบัญชี',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Column(
                //   children: [
                //
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
