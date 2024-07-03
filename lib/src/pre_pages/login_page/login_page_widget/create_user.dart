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

        // TODO: For Developing Only !!
        onLongPress: () {
          Navigator.pushNamed(context, '/bottomnav');
        },


        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff327B90),
          elevation: 0,
        ),
        child: Text(
          'Sign Up',
          style: GoogleFonts.raleway(
            color: const Color(0xffFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
