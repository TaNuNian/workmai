import 'package:flutter/material.dart';

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
            Flexible(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: width,
                    color: const Color(0xff67b4ca),
                    // child: Image.asset('lib/assets/images/login_banner.png'),
                  ),
                ],
              ),
            ),

            // Body
            Flexible(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.green,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      LoginTextbox(
                        hint: 'อีเมลล์',
                        obsec: false,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      LoginTextbox(
                        hint: 'รหัสผ่าน',
                        obsec: true,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      // Flexible(
                      //   child: FilledButton(
                      //     onPressed: Navigator.pushNamed(routeName: ''),
                      //     child: Container(width:,),
                      //   ),
                      // ),
                      Flexible(
                        flex: 4,
                        child: Row(
                          children: [],
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
