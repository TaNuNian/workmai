import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/cloud_firestore.dart';
import 'package:workmai/methods/cloud_firestore/profile_picker.dart';
import 'package:workmai/methods/storage/upload_image.dart';
import 'package:workmai/methods/user_provider.dart';
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
  File? _profileImage;
  File? _backgroundImage;
  String? _profileImageUrl;
  String? _backgroundImageUrl;
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

  Future<void> _selectProfileImage() async {
    try {
      File? image = await _uploader.pickImage();
      if (image != null) {
        setState(() {
          _profileImage = image;
        });
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking profile image: $e');
    }
  }

  Future<void> _selectBackgroundImage() async {
    try {
      File? image = await _uploader.pickImage();
      if (image != null) {
        setState(() {
          _backgroundImage = image;
        });
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking background image: $e');
    }
  }

  Future<void> _saveChanges() async {
    final imageProvider = Provider.of<UploadProfile>(context, listen: false);
    final profileProvider = Provider.of<ProfileProvider>(
        context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final userid = user?.uid;

    try {
      if (_profileImage != null) {
        _profileImageUrl = await _uploader.uploadProfileImage(_profileImage!);
      }

      if (_backgroundImage != null) {
        _backgroundImageUrl =
        await _uploader.uploadBackgroundImage(_backgroundImage!);
      }

      if (_profileImageUrl != null) {
        await imageProvider.updateProfilePicture(_profileImageUrl!);
      }

      if (_backgroundImageUrl != null) {
        await imageProvider.updateBackgroundPicture(_backgroundImageUrl!);
      }
      await CloudFirestore().updateUser(
          userid,
          profileProvider.profile.display_name == '' ? null: profileProvider.profile.display_name,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null);
      // After saving, navigate back or show success message
      Navigator.pop(context); // Or you can show a success message
    } catch (e) {
      print('Error saving changes: $e');
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
    final profileProvider = Provider.of<ProfileProvider>(context);
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
            onPressed: _saveChanges,
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
                vertical: MediaQuery
                    .sizeOf(context)
                    .height * 0.02,
                horizontal: MediaQuery
                    .sizeOf(context)
                    .width * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text('Preview:', style: TextStyle(fontSize: 16)),
                  Consumer<UploadProfile>(
                    builder: (context, uploadProfile, child) {
                      return Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff000000),
                            strokeAlign: BorderSide.strokeAlignCenter,
                          ),
                          image: _backgroundImage != null
                              ? DecorationImage(
                            image: FileImage(_backgroundImage!),
                            fit: BoxFit.cover,
                          )
                              : uploadProfile
                              .userData?['profile']['backgroundPicture'] != null
                              ? DecorationImage(
                            image: NetworkImage(uploadProfile
                                .userData!['profile']['backgroundPicture']),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: _selectBackgroundImage, // Add functionality here
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
                      Consumer<UploadProfile>(
                        builder: (context, uploadProfile, child) {
                          return CircleAvatar(
                            radius: 60,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : (uploadProfile
                                .userData?['profile']['profilePicture'] != null
                                ? NetworkImage(uploadProfile
                                .userData!['profile']['profilePicture'])
                                : null) as ImageProvider<Object>?,
                            backgroundColor: const Color(0xffD9D9D9),
                            child: _profileImage == null && uploadProfile
                                .userData?['profile']['profilePicture'] == null
                                ? const Icon(Icons.person, size: 60)
                                : null,
                          );
                        },
                      ),
                      TextButton(
                        onPressed: _selectProfileImage,
                        // Add functionality here
                        child: const Text('Change Profile', style: TextStyle(
                            fontSize: 18)),
                      )
                    ],
                  ),

                  // Display Name
                  const SizedBox(height: 20),
                  Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      if (userProvider.userData == null) {
                        return Center(child: CircularProgressIndicator(),);
                      }
                      return
                        Text(
                          'Display Name : ${userProvider
                              .userData?['profile']['display_name']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Change Display Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        profileProvider.profile.display_name = value;
                      });
                    },
                  ),

                  // Username
                  const SizedBox(height: 10),
                  Consumer<UploadProfile>(
                    builder: (context, uploadProfile, child) {
                      return Text(
                        'Username : ${uploadProfile.userData?['username'] ??
                            ''}',
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
                      _selectDate(context);
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