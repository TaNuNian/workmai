import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/profile_provider.dart';
import 'create_acc_birthday_header.dart';

class CreateAccBirthday extends StatefulWidget {
  final TextEditingController controller;

  const CreateAccBirthday({
    super.key,
    required this.controller,
  });

  @override
  _CreateAccBirthdayState createState() => _CreateAccBirthdayState();
}

class _CreateAccBirthdayState extends State<CreateAccBirthday> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      context.read<ProfileProvider>().updateBirthdate(picked);
      setState(() {
        widget.controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final birthdate = context.read<ProfileProvider>().profile.birthdate;
    if (birthdate != null) {
      widget.controller.text = "${birthdate.day}/${birthdate.month}/${birthdate.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          CreateAccBirthdayHeader(profile: context.read<ProfileProvider>().profile),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xffEEECEC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: TextField(
                controller: widget.controller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'เลือกวันเกิด',
                  hintStyle: GoogleFonts.sarabun(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  border: InputBorder.none,
                ),
                onTap: () => _selectDate(context),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create-acc-inter');
            },
            child: const Text('Bypass'),
          )
        ],
      ),
    );
  }
}
