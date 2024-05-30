import 'package:flutter/material.dart';

import 'login_textfield.dart';

class LoginTextbox extends StatelessWidget {
  final String hint;
  final bool obsec;
  const LoginTextbox({super.key, required this.hint, required this.obsec});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.black.withOpacity(0.4),
      child: LoginTextfield(
        hint: hint,
        obsec: obsec,
      ),
    );
  }
}

