import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:workmai/model/account.dart';

class RegisterTextfield extends StatefulWidget {
  final String hint;
  final bool obsec;
  final String? type;
  final Account account;
  final Color? color;

  const RegisterTextfield({
    super.key,
    required this.hint,
    required this.obsec,
    this.type,
    required this.account,
    this.color,
  });

  @override
  State<RegisterTextfield> createState() => _RegisterTextfieldState();
}

class _RegisterTextfieldState extends State<RegisterTextfield> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: TextFormField(
          keyboardType:
          widget.obsec ? TextInputType.text : TextInputType.emailAddress,
          onSaved: (String? value) {
            if (widget.type == 'Password') {
              widget.account.password = value ?? '';
              print("Password set to: ${widget.account.password}");
            } else if (widget.type == 'Confirm Password') {
              widget.account.confirmPassword = value ?? '';
              print("Confirm Password set to: ${widget.account.confirmPassword}");
            } else if (widget.type == 'Email Address') {
              widget.account.email = value ?? '';
              print("Email set to: ${widget.account.email}");
            }
          },
          controller: _controller,
          validator: MultiValidator([
            if (!widget.obsec)
              EmailValidator(
                  errorText: "โปรดใส่ ${widget.type.toString()} ที่ถูกต้อง"),
            if (widget.type.toString() == "Confirm Password")
              RequiredValidator(
                  errorText: "โปรดยืนยันรหัสผ่าน"),
            RequiredValidator(
                errorText: "โปรดใส่ ${widget.type.toString()}."),
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
          focusNode: _focusNode,
        ),
      ),
    );
  }
}
