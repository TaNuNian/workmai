import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/cloud_firestore.dart';
import 'package:workmai/methods/cloud_firestore/profile_picker.dart';
import 'package:workmai/methods/cloud_firestore/userservice.dart';
import 'package:workmai/methods/storage/upload_image.dart';
import 'package:workmai/methods/user_provider.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_page.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/myprofile_appear_edit.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

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
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
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
          profileProvider.profile.display_name == ''
              ? null
              : profileProvider.profile.display_name,
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
          null,
      null,
      null,);
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
    final User? user = _auth.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No user signed in')),
      );
    }
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _userService.fetchUserProfile(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No profile data found'));
          }

          final userProfile = snapshot.data!;
          return ProfilePage(
            button: _rowButton(context),
            userProfile: userProfile,
            showBackButton: false,
            isEdit: true,
          );
        },
      ),
    );
  }

  Widget _rowButton(BuildContext context) {
    return Row(
      children: [
        _editProfileButton(context),
        const SizedBox(width: 12),
        _editBackgroundButton(context),
        const SizedBox(width: 12),
        _onSaveButton(context),
      ],
    );
  }

  Widget _editProfileButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height * 0.1,
      ),
      child: SizedBox(
        width: 55,
        height: 55,
        child: GestureDetector(
          onTap: () {
            // TODO: On Save
            Navigator.pushNamed(context, '');
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff69B5CB),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.account_circle_outlined,
              color: Color(0xffffffff),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
  Widget _editBackgroundButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height * 0.1,
      ),
      child: SizedBox(
        width: 55,
        height: 55,
        child: GestureDetector(
          onTap: () {
            // TODO: On Save
            Navigator.pushNamed(context, '');
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff69B5CB),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.landscape_outlined,
              color: Color(0xffffffff),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  _onSaveButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height * 0.1,
      ),
      child: SizedBox(
        width: 55,
        height: 55,
        child: GestureDetector(
          onTap: () {
            // TODO: On Save
            Navigator.pushNamed(context, '');
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff69B5CB),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.save,
              color: Color(0xffffffff),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   final profileProvider = Provider.of<ProfileProvider>(context);
//   return Scaffold(
//     body: SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 _selectBackgroundImage;
//               },
//               child: Consumer<UploadProfile>(
//                 builder: (context, uploadProfile, child) {
//                   return Container(
//                     width: double.infinity,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: const Color(0xff000000),
//                         strokeAlign: BorderSide.strokeAlignCenter,
//                       ),
//                       image: _backgroundImage != null
//                           ? DecorationImage(
//                         image: FileImage(_backgroundImage!),
//                         fit: BoxFit.cover,
//                       )
//                           : uploadProfile
//                           .userData?['profile']['backgroundPicture'] != null
//                           ? DecorationImage(
//                         image: NetworkImage(uploadProfile
//                             .userData!['profile']['backgroundPicture']),
//                         fit: BoxFit.cover,
//                       )
//                           : null,
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             // Profile
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Consumer<UploadProfile>(
//                   builder: (context, uploadProfile, child) {
//                     return CircleAvatar(
//                       radius: 60,
//                       backgroundImage: _profileImage != null
//                           ? FileImage(_profileImage!)
//                           : (uploadProfile
//                           .userData?['profile']['profilePicture'] != null
//                           ? NetworkImage(uploadProfile
//                           .userData!['profile']['profilePicture'])
//                           : null) as ImageProvider<Object>?,
//                       backgroundColor: const Color(0xffD9D9D9),
//                       child: _profileImage == null && uploadProfile
//                           .userData?['profile']['profilePicture'] == null
//                           ? const Icon(Icons.person, size: 60)
//                           : null,
//                     );
//                   },
//                 ),
//                 TextButton(
//                   onPressed: _selectProfileImage,
//                   // Add functionality here
//                   child: const Text('Change Profile', style: TextStyle(
//                       fontSize: 18)),
//                 )
//               ],
//             ),
//
//             // Display Name
//             const SizedBox(height: 20),
//             Consumer<UserProvider>(
//               builder: (context, userProvider, child) {
//                 if (userProvider.userData == null) {
//                   return Center(child: CircularProgressIndicator(),);
//                 }
//                 return
//                   Text(
//                     'Display Name : ${userProvider
//                         .userData?['profile']['display_name']}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   );
//               },
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _controller,
//               focusNode: _focusNode,
//               decoration: const InputDecoration(
//                 hintText: 'Change Display Name',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   profileProvider.profile.display_name = value;
//                 });
//               },
//             ),
//
//             // Username
//             const SizedBox(height: 10),
//             Consumer<UploadProfile>(
//               builder: (context, uploadProfile, child) {
//                 return Text(
//                   'Username : ${uploadProfile.userData?['username'] ??
//                       ''}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 );
//               },
//             ),
//
//             // Select Active Time
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 _selectDate(context);
//               },
//               style: ElevatedButton.styleFrom(),
//               child: Text(
//                 activetime,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//
//             // Select Interest
//             const SizedBox(height: 30),
//             const SizedBox(
//               height: 600,
//               child: Placeholder(), // Replace with CreateAccInterBox
//             ),
//
//             // Select Skill
//             const SizedBox(height: 30),
//             const SizedBox(
//               height: 600,
//               child: Placeholder(), // Replace with CreateAccSkillBox
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
