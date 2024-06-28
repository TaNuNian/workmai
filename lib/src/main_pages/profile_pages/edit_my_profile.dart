import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/profile_picker.dart';
import 'package:workmai/methods/storage/upload_image.dart';
import 'package:workmai/model/profile_provider.dart';

class EditMyProfile extends StatefulWidget {
  const EditMyProfile({super.key});

  @override
  _EditMyProfileState createState() => _EditMyProfileState();
}

class _EditMyProfileState extends State<EditMyProfile> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late String activetime;
  File? _image;
  final ProfileImageUploader _uploader = ProfileImageUploader();

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

  Future<void> _uploadProfileImage() async {
    try {
      File? image = await _uploader.pickImage();
      if (image != null) {
        String? downloadUrl = await _uploader.uploadImage(image);
        print('*******************  $downloadUrl');
        if (downloadUrl != null) {
          final profileProvider = Provider.of<UploadProfile>(context, listen: false);
          await profileProvider.updateProfilePicture(downloadUrl);
        } else {
          print('Failed to get download URL');
        }
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error uploading profile image: $e');
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
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xff327b90),
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
      ),
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
                  const Text('Preview:', style: TextStyle(fontSize: 16)),
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
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(),
                    child: const Text(
                      'เปลี่ยนพื้นหลัง',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  // Profile
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xffD9D9D9),
                      ),
                      TextButton(
                        onPressed:  _uploadProfileImage, // Add functionality here
                        child: const Text('Change Profile', style: TextStyle(fontSize: 18)),
                      )
                    ],
                  ),

                  // Display Name
                  const SizedBox(height: 20),
                  Consumer<UploadProfile>(
                    builder: (context, uploadProfile, child) {
                      return Text(
                        'Display Name : ${uploadProfile.userData?['displayName'] ?? ''}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                  TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Change Display Name',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  // Username
                  const SizedBox(height: 10),
                  Consumer<UploadProfile>(
                    builder: (context, uploadProfile, child) {
                      return Text(
                        'Username : ${uploadProfile.userData?['username'] ?? ''}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
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
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Select Interest
                  const SizedBox(height: 30),
                  const SizedBox(
                    height: 600,
                    child: Placeholder(), // Replace with CreateAccInterBox
                  ),

                  // Select Skill
                  const SizedBox(height: 30),
                  const SizedBox(
                    height: 600,
                    child: Placeholder(), // Replace with CreateAccSkillBox
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
