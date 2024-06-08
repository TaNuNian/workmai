import 'package:flutter/material.dart';
import 'package:workmai/model/account.dart';
import 'package:workmai/src/pre_pages/register_page/register_page_wg/register_textfield.dart';

class RegisterTextbox extends StatelessWidget {
  final String hint;
  final bool obsec;
  final String type;
  final Account account;
  final Color? color;

  const RegisterTextbox({
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
        color: color ?? const Color(0xffEEECEC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: RegisterTextfield(
        hint: hint,
        obsec: obsec,
        type: type,
        account: account,
        color: color,
      ),
    );
  }
}
