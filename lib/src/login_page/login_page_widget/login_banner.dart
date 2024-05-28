import 'package:flutter/material.dart';

class LoginBanner extends StatelessWidget {
  const LoginBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Flexible(
      // flex: 3,
      child: Stack(
        children: [
          Container(
            width: width,
            color: const Color(0xff67b4ca),
            // child: Image.asset('lib/assets/images/login_banner.png'),
          ),
        ],
      ),
    );
  }
}
