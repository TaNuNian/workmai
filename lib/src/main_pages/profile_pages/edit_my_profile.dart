import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/decor/continue_button.dart';
import 'package:workmai/src/decor/padding.dart';
import 'package:workmai/src/decor/textfield_decor.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/edit_profile_wg/edit_profile_app_bar.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/create_acc_inter/create_acc_inter_box.dart';

import '../../pre_pages/create_account_pages/create_acc_ness/create_acc_skill/create_acc_skill_box.dart';

class EditMyProfile extends StatefulWidget {
  const EditMyProfile({super.key});

  @override
  _EditMyProfileState createState() => _EditMyProfileState();
}

class _EditMyProfileState extends State<EditMyProfile> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late String activetime;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode.unfocus();
    activetime = 'Current activetime'; // TODO
  }

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
        activetime = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: editProfileAppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            _focusNode.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * 0.02,
                horizontal: MediaQuery.sizeOf(context).width * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Background
                  Text('Preview:', style: GoogleFonts.sarabun(fontSize: 16)),
                  Container(
                    width: double.infinity,
                    height: 200, // TODO: ปรับๆเอาละกัน
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff000000),
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                      // image: Image.asset('') // TODO: Add Image from changes
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: เลือกรูปจากเครื่อง
                    },
                    style: ElevatedButton.styleFrom(),
                    child: Text(
                      'เปลี่ยนพื้นหลัง',
                      style: GoogleFonts.sarabun(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  // Profile
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xffD9D9D9),
                      ),
                      ContinueButton(actionName: 'Change Profile',routeName: '', funcCheckUsernameBD: false)
                    ],
                  ),

                  // Display Name
                  const SizedBox(height: 20),
                  Text(
                    'Display Name : {DisplayName}',
                    style: GoogleFonts.sarabun(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextField(
                    // controller: _controller,
                    // focusNode: _focusNode,
                    decoration: textfieldDec('Change Display Name'),
                  ),

                  // Username
                  const SizedBox(height: 10),
                  Text(
                    'Username : {Username}',
                    style: GoogleFonts.sarabun(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Select Active Time
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: เลือกเวลา
                    },
                    style: ElevatedButton.styleFrom(),
                    child: Text(
                      activetime,
                      style: GoogleFonts.sarabun(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Select Interest
                  const SizedBox(height: 30),
                  const SizedBox(
                    height: 600,
                    child: CreateAccInterBox(),
                  ),

                  // Select Skill
                  const SizedBox(height: 30),
                  const SizedBox(
                    height: 600,
                    child: CreateAccSkillBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar editProfileAppBar() {
    return AppBar(
      title: Text(
        'Edit Profile',
        style: GoogleFonts.sarabun(
          color: const Color(0xff327b90),
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            // TODO: SAVE and EXIT TO Profile with changes
          },
          iconSize: 32,
        )
      ],
      elevation: 0,
    );
  }
}
