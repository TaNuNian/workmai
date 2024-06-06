import 'package:flutter/material.dart';
import 'package:workmai/model/account.dart';

import 'login_textfield.dart';

class LoginTextbox extends StatelessWidget {
  final String hint;
  final bool obsec;
  final String type;
  final Account account;
  final Color? color;

  const LoginTextbox({
    super.key,
    required this.hint,
    required this.obsec,
    required this.type,
    required this.account,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          color: const Color(0xffEEECEC),
          borderRadius: BorderRadius.circular(15)),
      child: LoginTextfield(
        hint: hint,
        obsec: obsec,
        type: type,
        account: account,
        color: color,
      ),
    );
  }
}
