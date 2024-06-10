import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/model/account.dart';

class UsernameTextbox extends StatefulWidget {
  final String hint;
  final String type;
  final Color? color;

  const UsernameTextbox({
    super.key,
    required this.hint,
    required this.type,
    this.color,
  });

  @override
  State<UsernameTextbox> createState() => _UsernameTextboxState();
}

class _UsernameTextboxState extends State<UsernameTextbox> {
  final GlobalKey textFieldKey = GlobalKey();
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.type;
    final hint = widget.hint;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(type, style: GoogleFonts.sarabun(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xffEEECEC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: TextFormField(
                key: textFieldKey,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: hint,
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
          ),
        ],
      ),
    );
  }
}
