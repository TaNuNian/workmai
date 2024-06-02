import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:workmai/model/account.dart';

class LoginTextfield extends StatefulWidget {
  final String hint;
  final bool obsec;
  final String type;
  final Profile profile;
  final GlobalKey<FormState> formKey;

  const LoginTextfield(
      {super.key,
      required this.hint,
      required this.obsec,
      required this.type,
      required this.profile,
      required this.formKey});

  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Form(
          key: _formKey,
          child: TextFormField(
            keyboardType:
                widget.obsec ? TextInputType.text : TextInputType.emailAddress,
            onSaved: (String? value) {
              if (widget.obsec) {
                profile.password = value ?? '';
                print(profile.password);
              } else if (widget.obsec) {
                profile.email = value ?? '';
                print(profile.email);
              }
            },
            controller: _controller,
            validator: MultiValidator([
              RequiredValidator(
                  errorText: "โปรดใส่ ${widget.type.toString()}."),
              if (!widget.obsec)
                EmailValidator(
                    errorText: "โปรดใส่ ${widget.type.toString()} ที่ถูกต้อง"),
            ]).call,
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
      ),
    );
  }
}
