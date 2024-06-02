import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';

import '../../../../model/account.dart';

class SigninButton extends StatelessWidget {
  final Profile profile;
  final GlobalKey<FormState> formKey;

  const SigninButton({super.key, required this.profile, required this.formKey});

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
          if (formKey.currentState!.validate()) {
            formKey.currentState?.save();
            print("email= ${profile.email}, password= ${profile.password}");
            formKey.currentState?.reset(); // CHECK EMAIL / PASSWORD HERE
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          'ลงชื่อเข้าใช้',
          style: GoogleFonts.sarabun(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
