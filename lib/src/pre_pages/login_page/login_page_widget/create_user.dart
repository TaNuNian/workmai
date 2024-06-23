import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateUser extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const CreateUser({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register', arguments: formKey);
        },
        onLongPress: () {
          Navigator.pushNamed(context, '/bottomnav');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffE3E3E3),
          elevation: 0,
        ),
        child: Text(
          'สร้างบัญชี',
          style: GoogleFonts.sarabun(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
