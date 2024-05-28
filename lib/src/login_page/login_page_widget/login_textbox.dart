import 'package:flutter/material.dart';

import 'login_textfield.dart';

class LoginTextbox extends StatelessWidget {
  final String hint;
  final bool obsec;
  const LoginTextbox({super.key, required this.hint, required this.obsec});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        height: 20,
        color: Colors.red,
        child: LoginTextfield(
          hint: hint,
          obsec: obsec,
        ),
      ),
    );
  }
}

