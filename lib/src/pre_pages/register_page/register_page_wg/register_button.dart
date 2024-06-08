import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/Authentication.dart';
import 'package:workmai/model/account.dart';
import 'package:workmai/src/decor/gradients.dart';

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Account account;

  const RegisterButton({
    super.key,
    required this.account,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.5,
      height: MediaQuery.sizeOf(context).height * 0.06,
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
            signUp(context, account);
          }

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Center(
          child: Text(
            'ลงทะเบียน',
            style: GoogleFonts.sarabun(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
