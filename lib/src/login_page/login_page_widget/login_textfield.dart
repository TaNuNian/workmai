import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:workmai/model/account.dart';

class LoginTextfield extends StatefulWidget {
  final String hint;
  final bool obsec;
  final String type;

  const LoginTextfield(
      {super.key, required this.hint, required this.obsec, required this.type});

  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');

  // String password = '';
  // String email = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType:
              widget.obsec ? TextInputType.text : TextInputType.emailAddress,
          onSaved: (String? value) {
            if (widget.obsec) {
              profile.password = value ?? '';
            } else if (widget.obsec) {
              profile.email = value ?? '';
            }
          },
          controller: _controller,
          validator: MultiValidator(
            [
              RequiredValidator(errorText: "โปรดใส่ ${widget.type}."),
              if (!widget.obsec)
                EmailValidator(errorText: "โปรดใส่ ${widget.type} ที่ถูกต้อง"),
              ],
          ),
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
      ),
    );
  }
}
