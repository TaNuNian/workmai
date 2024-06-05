import 'package:flutter/material.dart';
import 'package:workmai/model/account.dart';
import 'package:workmai/src/decor/padding.dart';

import 'package:workmai/src/custom_appbar/custom_appbar.dart';
import 'package:workmai/src/default_page/default_scf.dart';
import 'package:workmai/src/pre_pages/register_page/register_page_wg/register_body.dart';
import 'package:workmai/src/pre_pages/register_page/register_page_wg/register_header_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  List<String> profile = registerText;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return DefaultScf(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            // decoration: BoxDecoration(
            //   color: Colors.red
            // ),
            child: RegisterChildren(),
          ),
        ),
      ),
    );
  }
}
