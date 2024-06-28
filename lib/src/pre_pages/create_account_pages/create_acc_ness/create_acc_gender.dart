import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/profile_provider.dart';

class CreateAccGender extends StatefulWidget {
  final TextEditingController controller;

  const CreateAccGender({super.key, required this.controller});

  @override
  State<CreateAccGender> createState() => _CreateAccGenderState();
}

class _CreateAccGenderState extends State<CreateAccGender> {
  final List<String> gender = [
    'ชาย',
    'หญิง',
    'ไม่ระบุ',
  ];

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  'เพศ',
                  style: GoogleFonts.sarabun(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffEEECEC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: DropdownButtonFormField<String>(
                  value: profileProvider.profile.gender,
                  hint: Text(
                    'เลือกเพศ',
                    style: GoogleFonts.sarabun(
                        color: Colors.black45,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.2),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      profileProvider.profile.gender = newValue;
                    });
                    print(profileProvider.profile.gender);
                  },
                  items: gender.map((String sex) {
                    return DropdownMenuItem<String>(
                      value: sex,
                      child: Text(
                        sex,
                        style: GoogleFonts.sarabun(
                            color: Colors.black45,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.2),
                      ),
                    );
                  }).toList(),
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  // Remove the default underline
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  style: GoogleFonts.sarabun(fontSize: 18, color: Colors.black),
                  dropdownColor: Colors.white,
                  menuMaxHeight: 200,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
