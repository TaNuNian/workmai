import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/Authentication.dart';
import 'package:workmai/model/account.dart';
import 'package:workmai/src/decor/gradients.dart';

class SigninButton extends StatelessWidget {
  final Account account;
  final GlobalKey<FormState> formKey;

  const SigninButton({
    super.key,
    required this.account,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Container(
      width: width * 0.4,
      height: height * 0.08,
      decoration: BoxDecoration(
        gradient: crossLinearGradient,
        borderRadius: BorderRadius.circular(
            (MediaQuery.sizeOf(context).height * 0.06) / 2),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState != null && formKey.currentState!.validate()) {
            formKey.currentState?.save();
            print("email= ${account.email}, password= ${account.password}");
            formKey.currentState?.reset();// CHECK EMAIL / PASSWORD HERE
            signIn(context, account);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          'Sign In',
          style: GoogleFonts.raleway(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
