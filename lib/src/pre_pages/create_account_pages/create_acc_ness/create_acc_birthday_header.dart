import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/model/profile.dart';

class CreateAccBirthdayHeader extends StatefulWidget {
  final Profile profile;
  const CreateAccBirthdayHeader({super.key,required this.profile});

  @override
  _CreateAccBirthdayHeaderState createState() => _CreateAccBirthdayHeaderState();
}

class _CreateAccBirthdayHeaderState extends State<CreateAccBirthdayHeader> {

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != widget.profile.birthdate)
      setState(() {
        widget.profile.birthdate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'วันเกิด',
            style: GoogleFonts.sarabun(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
            child: Text(
              'เลือกวันเกิด',
              style: GoogleFonts.sarabun(
                  fontSize: 24,
                  color: const Color(0xff327B90)),
            ),
          )
        ],
      ),
    );
  }
}
