import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/model/account.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/login_profile.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/login_textbox.dart';
import 'package:workmai/src/pre_pages/register_page/register_page_wg/register_textbox.dart';

class RegisterChildrenWg extends StatefulWidget {
  final String child;

  const RegisterChildrenWg({super.key, required this.child});

  @override
  State<RegisterChildrenWg> createState() => _RegisterChildrenWgState();
}

class _RegisterChildrenWgState extends State<RegisterChildrenWg> {
  final Account _account = signupAccount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ColoredBox(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.child.toString(),
              style: GoogleFonts.sarabun(
                color: const Color(0xff327B90),
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            Container(
              child: RegisterTextbox(
                hint: widget.child.toString(),
                obsec: widget.child.toString() == 'Email Address' ? false : true,
                account: _account,
                type: widget.child.toString(),
                color: const Color(0xffD7F4E9),
              ),
            )
          ],
        ),
      ),
    );
  }
}