import 'package:flutter/material.dart';
import 'package:workmai/src/decor/padding.dart';

import '../../custom_appbar/custom_appbar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: CustomAppbar(
        height: MediaQuery.sizeOf(context).height * 0.1,
      ),
      body: SafeArea(
        child: Padding(
          padding: bodyPadding(context),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
