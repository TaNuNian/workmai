import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/chat.dart';
import 'package:workmai/methods/cloud_firestore/co_worker_service.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/methods/storage/upload_image.dart';
import 'package:workmai/model/matching_user_provider.dart';
import 'package:workmai/src/decor/match_result_tile.dart';

class MatchingList extends StatefulWidget {
  final bool isFriend;

  const MatchingList({super.key, required this.isFriend});

  @override
  State<MatchingList> createState() => _MatchingListState();
}

class _MatchingListState extends State<MatchingList> {
  List<DocumentSnapshot> chatList = [];
  String? selectedChatId;
  final ChatService _chatService = ChatService();
  final CoWorkerService _coWorkerService = CoWorkerService();
  List<Map<String, dynamic>> friendsList = [];
  List<String> selectedFriends = [];
  List<Map<String, dynamic>> matchingUsers = [];
  File? _groupProfileImage;
  final ProfileImageUploader _uploader = ProfileImageUploader();
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String selectedTab = 'Create';

  @override
  void initState() {
    super.initState();
    _fetchChatList();
    _fetchFriends();
  }

  Future<void> _fetchChatList() async {
    chatList = await _chatService.fetchGroupChats(widget.isFriend);
    setState(() {});
  }

  Future<void> _fetchFriends() async {
    List<Map<String, dynamic>> friends = await FriendService().fetchFriends();
    setState(() {
      friendsList = friends;
    });
  }

  Future<void> createGroupChat(StateSetter setState) async {
    final myFriends = selectedFriends
        .where((id) => friendsList.any((friend) => friend['uid'] == id))
        .toList();
    if (_groupNameController.text.isEmpty || selectedFriends.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a group name and select members')),
      );
      return;
    }

    String? profileImageUrl;
    if (_groupProfileImage != null) {
      profileImageUrl =
          await _uploader.uploadGroupProfileImage(_groupProfileImage!);
    }
    try {
      ChatService chatService = ChatService();
      String groupId = await chatService.createGroupChat(
        _groupNameController.text,
        myFriends,
        widget.isFriend,
        profileImageUrl: profileImageUrl,
      );
      for (String friend in myFriends) {
        await chatService.addChatToUser(groupId, friend, widget.isFriend);
      }

      selectedChatId = groupId; // Store the groupId for sending invitations

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Group created: $groupId')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error creating group chat: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating group chat')),
        );
      }
    }
  }

  void _showNextBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16),
                  Text(
                    "Do you want to tell them something?",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await _requestAction(context);
                    },
                    child: Text('Request'),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _requestAction(BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid;
    final receiverIds = selectedFriends.where((id) => id != userId).toList();
    if (selectedTab == 'Create') {
      if (_groupNameController.text.isEmpty || selectedFriends.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Please enter a group name and select members')),
          );
        }
        return;
      }

      String? profileImageUrl;
      if (_groupProfileImage != null) {
        profileImageUrl =
            await _uploader.uploadGroupProfileImage(_groupProfileImage!);
      }else{
        profileImageUrl = '';
      }
      try {
        // Create the group chat and add only friends
        await createGroupChat(setState);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Group created successfully.')),
          );
        }
        await _coWorkerService.sendMatchingRequest(
          groupName: _groupNameController.text,
          receiverIds: selectedFriends,
          type: 'create',
          message: _messageController.text,
          profileImage: _groupProfileImage != null
              ? await _uploader.uploadGroupProfileImage(_groupProfileImage!)
              : null,
          chatId: selectedChatId,
        );
        Navigator.pop(context);
        Navigator.pop(context); // Close both bottom sheets
      } catch (e) {
        print('Error creating group chat: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating group chat')),
          );
        }
      }
    } else if (selectedTab == 'Invite') {
      if (selectedChatId == null || selectedFriends.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select a group and members')),
          );
        }
        return;
      }
      await _coWorkerService.sendMatchingRequest(
        groupName: '',
        receiverIds: receiverIds,
        type: 'invite',
        message: _messageController.text,
        chatId: selectedChatId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'YOUR SELECTED MATCHING',
        style: GoogleFonts.raleway(
          color: const Color(0xff327B90),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: BackButton(
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Consumer<MatchingUserProvider>(
      builder: (context, userProvider, child) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: userProvider.uids.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(userProvider.uids[index])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.hasError) {
                        return ListTile(
                          title: Text('Error loading user data'),
                        );
                      }

                      var userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      var profile = userData['profile'];

                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: MatchResultTile(
                          color: Color(0xff327B90),
                          displayname: profile['display_name'] ?? 'N/A',
                          username: profile['name'] ?? 'N/A',
                          profilePicture: profile['profilePicture'] ?? '',
                          uid: userProvider.uids[index],
                          alreadyMatch: true,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => _optionModalContent(context),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        style: GoogleFonts.raleway(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff327B90)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _optionModalContent(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'Options',
                      style: GoogleFonts.raleway(
                        color: const Color(0xff327B90),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    bottom: TabBar(
                      onTap: (index) {
                        setState(() {
                          selectedTab = index == 0 ? 'Create' : 'Invite';
                        });
                      },
                      tabs: const [
                        Tab(text: 'Create'),
                        Tab(text: 'Invite'),
                      ],
                      labelColor: const Color(0xff327B90),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: const Color(0xff327B90),
                      indicatorWeight: 2.0,
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      _createTabContent(context, setState),
                      _inviteTabContent(context, setState),
                    ],
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _showNextBottomSheet(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Next',
                            style: GoogleFonts.raleway(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff327B90),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _inviteTabContent(BuildContext context, StateSetter setState) {
    final matchingUsers = context.watch<MatchingUserProvider>().uids;

    return selectedChatId == null
        ? chatList.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        final chat = chatList[index].data() as Map<String, dynamic>;
        final chatName = chat['groupName'] ?? 'Unnamed Group';
        final chatImage = chat['groupProfileImage'] ?? '';

        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: chatImage.isNotEmpty
                    ? NetworkImage(chatImage)
                    : null,
                child: chatImage.isEmpty ? Icon(Icons.group) : null,
              ),
              title: Text(
                chatName,
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                setState(() {
                  if (selectedChatId == chatList[index].id) {
                    selectedChatId = '';
                  } else {
                    selectedChatId = chatList[index].id;
                  }
                });
              },
              selected: selectedChatId == chatList[index].id,
              selectedTileColor: Colors.grey.withOpacity(0.2),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.black12,
                height: 8,
              ),
            ),
          ],
        );
      },
    )
        : Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: chatList.any((chat) => chat.id == selectedChatId) &&
                chatList.firstWhere((chat) => chat.id == selectedChatId)['groupProfileImage'] != ''
                ? NetworkImage(chatList.firstWhere((chat) => chat.id == selectedChatId)['groupProfileImage'])
                : null,
            child: chatList.any((chat) => chat.id == selectedChatId) &&
                chatList.firstWhere((chat) => chat.id == selectedChatId)['groupProfileImage'] == ''
                ? Icon(Icons.group)
                : null,
          ),
          title: Text(
            chatList.any((chat) => chat.id == selectedChatId)
                ? chatList.firstWhere((chat) => chat.id == selectedChatId)['groupName']
                : 'Unnamed Group',
            style: GoogleFonts.raleway(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            setState(() {
              selectedChatId = null;
            });
          },
          selected: true,
          selectedTileColor: Colors.grey.withOpacity(0.2),
        ),
        Divider(color: Colors.black12, height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: matchingUsers.length,
            itemBuilder: (context, index) {
              final userId = matchingUsers[index];
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final userData =
                  snapshot.data!.data() as Map<String, dynamic>;
                  final profile = userData['profile'];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: profile['profilePicture'] != ''
                          ? NetworkImage(profile['profilePicture'])
                          : null,
                      child: profile['profilePicture'] == ''
                          ? Icon(Icons.person)
                          : null,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          profile['display_name'] == ''
                              ? 'Display Name'
                              : profile['display_name'],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text('@' + (profile['name'] ?? ''),
                            style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        if (selectedFriends.contains(userId)) {
                          selectedFriends.remove(userId);
                        } else {
                          selectedFriends.add(userId);
                        }
                      });
                    },
                    trailing: selectedFriends.contains(userId)
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.check_circle_outline),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _createTabContent(BuildContext context, StateSetter setState) {
    final matchingUsers = context.watch<MatchingUserProvider>().uids;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _groupNameController,
            decoration: InputDecoration(
              labelText: 'Group Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              File? image = await ProfileImageUploader().pickImage();
              if (image != null) {
                setState(() {
                  _groupProfileImage = image;
                });
              }
            },
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
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: matchingUsers.length + friendsList.length,
              itemBuilder: (context, index) {
                final isMatchingUser = index < matchingUsers.length;
                final userId = isMatchingUser
                    ? matchingUsers[index]
                    : friendsList[index - matchingUsers.length]['uid'];
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    final profile = userData['profile'];
                    final isSelected = selectedFriends.contains(userId);

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: profile['profilePicture'] != ''
                            ? NetworkImage(profile['profilePicture'])
                            : null,
                        child: profile['profilePicture'] == ''
                            ? Icon(Icons.person)
                            : null,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            profile['display_name'] == ''
                                ? 'Display Name'
                                : profile['display_name'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text('@' + (profile['name'] ?? ''),
                              style: TextStyle(fontSize: 13)),
                        ],
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : Icon(Icons.check_circle_outline),
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedFriends.remove(userId);
                          } else {
                            selectedFriends.add(userId);
                          }
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
