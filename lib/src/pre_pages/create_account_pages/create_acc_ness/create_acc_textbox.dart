import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/profile_provider.dart';

class UsernameTextbox extends StatelessWidget {
  final String hint;
  final String type;
  final TextEditingController controller;
  final Color? color;

  const UsernameTextbox({
    super.key,
    required this.hint,
    required this.type,
    required this.controller,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
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
                controller: controller,
                onChanged: (value){
                  context.read<ProfileProvider>().updateName(value);
                },
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: GoogleFonts.sarabun(
                    color: Colors.black.withOpacity(0.3),
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
