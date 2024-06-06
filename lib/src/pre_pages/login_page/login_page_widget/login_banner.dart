import 'package:flutter/material.dart';

class LoginBanner extends StatelessWidget {
  const LoginBanner({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Container(
      width: width,
      height: height * 0.3,
      decoration: const BoxDecoration(
        color: Color(0xff67b4ca),
      ),
      child: Image.asset('lib/assets/login_banner.png'),
    );
  }
}
