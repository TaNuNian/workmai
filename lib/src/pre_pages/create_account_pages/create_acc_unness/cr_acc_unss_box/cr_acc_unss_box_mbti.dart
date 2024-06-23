import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_box.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_text.dart';

class CrAccUnssBoxMbti extends StatefulWidget {
  const CrAccUnssBoxMbti({super.key});

  @override
  _CrAccUnssBoxMbtiState createState() => _CrAccUnssBoxMbtiState();
}

class _CrAccUnssBoxMbtiState extends State<CrAccUnssBoxMbti> {

  final List<String> mbtiTypes = [
    'INTJ',
    'INTP',
    'ENTJ',
    'ENTP',
    'INFJ',
    'INFP',
    'ENFJ',
    'ENFP',
    'ISTJ',
    'ISFJ',
    'ESTJ',
    'ESFJ',
    'ISTP',
    'ISFP',
    'ESTP',
    'ESFP',
  ];

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Column(
        children: [
          const CrAccUnssBoxText(
            header: 'Which MBTI personality are you?',
          ),
          CrAccUnssBoxBox(
            child: DropdownButtonFormField<String>(
              value: profileProvider.profile.mbti,
              hint: Text(
                'Select MBTI',
                style: GoogleFonts.sarabun(
                  color: Colors.black45,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.2),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  profileProvider.profile.mbti = newValue;
                });
                print(profileProvider.profile.mbti);
              },
              items: mbtiTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type, style: GoogleFonts.sarabun(
                        color: Colors.black45,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.2),),
                );
              }).toList(),
              isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffE5F1D3),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xffE5F1D3),
                      width: 1,
                    ),
                  ),
                ), // Remove the default underline
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              style: GoogleFonts.sarabun(fontSize: 18, color: Colors.black),
              dropdownColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
