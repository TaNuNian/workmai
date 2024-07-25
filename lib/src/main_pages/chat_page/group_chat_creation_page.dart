import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/chat.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/methods/storage/upload_image.dart';
import 'package:workmai/model/matching_user_provider.dart';

class GroupChatCreationPage extends StatefulWidget {
  final bool isFriend;

  const GroupChatCreationPage({super.key, required this.isFriend});

  @override
  _GroupChatCreationPageState createState() => _GroupChatCreationPageState();
}

class _GroupChatCreationPageState extends State<GroupChatCreationPage> {
  final FriendService _friendService = FriendService();
  final TextEditingController _groupNameController = TextEditingController();
  List<Map<String, dynamic>> friendsList = [];
  List<String> selectedFriends = [];
  File? _groupProfileImage;
  final ProfileImageUploader _uploader = ProfileImageUploader();

  @override
  void initState() {
    super.initState();
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    List<Map<String, dynamic>> friends = await _friendService.fetchFriends();
    setState(() {
      friendsList = friends;
    });
  }

  Future<void> _pickImage() async {
    File? image = await _uploader.pickImage();
    if (image != null) {
      setState(() {
        _groupProfileImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Create Group Chat', style: TextStyle(fontSize: 24)),
      centerTitle: true,
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _groupNameField(),
            SizedBox(height: 20),
            _profileImageField(),
            SizedBox(height: 20),
            _friendsList(),
          ],
        ),
      ),
    );
  }

  Widget _groupNameField() {
    return TextField(
      controller: _groupNameController,
      decoration: InputDecoration(
        labelText: 'Group Name',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(75),
          image: _groupProfileImage != null
              ? DecorationImage(
                  image: FileImage(_groupProfileImage!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _groupProfileImage == null
            ? Icon(Icons.add_a_photo, size: 50, color: Colors.white)
            : null,
      ),
    );
  }

  Widget _friendsList() {
    return Expanded(
      child: friendsList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: friendsList.length,
              itemBuilder: (context, index) {
                final friend = friendsList[index];
                final isSelected = selectedFriends.contains(friend['uid']);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: friend['profilePicture'] != ''
                        ? NetworkImage(friend['profilePicture'])
                        : null,
                    child: friend['profilePicture'] == ''
                        ? Icon(Icons.person)
                        : null,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        friend['displayName'] == ''
                            ? 'Display Name'
                            : friend['displayName'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '@' + friend['name'],
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Icon(Icons.check_circle_outline),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedFriends.remove(friend['uid']);
                      } else {
                        selectedFriends.add(friend['uid']);
                      }
                    });
                  },
                );
              },
            ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => createGroupChat(context),
      child: Icon(Icons.check),
    );
  }

  Future<void> createGroupChat(BuildContext context) async {
    if (_groupNameController.text.isEmpty || selectedFriends.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a group name and select members')),
      );
      return;
    }

    String? profileImageUrl;
    if (_groupProfileImage != null) {
      profileImageUrl = await _uploader.uploadGroupProfileImage(_groupProfileImage!);
    }
    try {
      ChatService chatService = ChatService();
      String groupId = await chatService.createGroupChat(
        _groupNameController.text,
        selectedFriends,
        widget.isFriend, // ส่งค่า isFriend ไปด้วย
        profileImageUrl: profileImageUrl,
      );
      for (String friend in selectedFriends){
        await chatService.addChatToUser(groupId, friend, widget.isFriend);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Group created: $groupId')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error creating group chat: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating group chat')),
      );
    }
  }
}
