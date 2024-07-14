import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:workmai/model/account.dart';

class LoginTextfield extends StatefulWidget {
  final String hint;
  final bool obsec;
  final String? type;
  final Account account;
  final Color? color;

  const LoginTextfield({
    super.key,
    required this.hint,
    required this.obsec,
    this.type,
    required this.account,
    this.color,
  });

  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  late TextEditingController _textEditingController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode.unfocus();
    super.initState();
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
            if (widget.obsec) {
              widget.account.password = value ?? '';
              print(widget.account.password);
            } else {
              widget.account.email = value ?? '';
              print(widget.account.email);
            }
          },
          controller: _textEditingController,
          validator: MultiValidator([
            RequiredValidator(
                errorText: "Enter ${widget.type.toString()}."),
            if (!widget.obsec)
              EmailValidator(
                  errorText: "Enter valid ${widget.type.toString()}"),
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
