import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_acc_birthday_header.dart';

class CreateAccBirthday extends StatefulWidget {
  const CreateAccBirthday({super.key});

  @override
  _CreateAccBirthdayState createState() => _CreateAccBirthdayState();
}

class _CreateAccBirthdayState extends State<CreateAccBirthday> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          CreateAccBirthdayHeader(),
        ],
      ),
    );
  }
}
