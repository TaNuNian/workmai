import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

class LoginTextfield extends StatefulWidget {
  final String hint;
  final bool obsec;

  const LoginTextfield({super.key, required this.hint, required this.obsec});

  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _controller,
        obscureText: widget.obsec,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: GoogleFonts.sarabun(
            color: Colors.black.withOpacity(0.3),
            fontSize: 16,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
