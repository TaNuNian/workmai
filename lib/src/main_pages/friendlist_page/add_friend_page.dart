import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/src/decor/friend_list_tile.dart';
import 'package:workmai/src/decor/search_tab.dart';
import 'package:workmai/src/decor/textfield_decor.dart';
import 'package:workmai/src/decor/theme.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final FriendService _friendService = FriendService();

  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode.unfocus();
    super.initState();
  }

  Future<void> _searchFriends() async {
    setState(() {
      _isLoading = true;
    });

    final results = await _friendService.searchUsers(_controller.text);

    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  AppBar _appbar(context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: const Color(0xff59A1B6),
        iconSize: 30,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'ADD FRIENDS',
        style: appBarTitleStyle(const Color(0xff59A1B6)),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  _body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search tab
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomSearchTab(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: textfieldSearchDec('@username'),
                    onSubmitted: (value) => _searchFriends(),
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ),
              // Search result Box
              Container(
                height: 800,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xffB8E175),
                    strokeAlign: BorderSide.strokeAlignCenter,
                    width: 1,
                  ),
                ),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _searchResults.isEmpty
                        ? Container(
                  margin: const EdgeInsets.only(top: 24),
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Find your friend via Username !',
                    style: GoogleFonts.raleway(color: const Color(0xff8E8E8E), fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
                        : ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final friend = _searchResults[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FriendList(
                                  color: const Color(0xffededed),
                                  displayname:
                                      friend['displayName'] ?? 'No display name',
                                  username: friend['name'] ?? 'No username',
                                  profilePicture: friend['profilePicture'],
                                  onTap: () =>
                                      // _friendService.addFriend(friend['uid']),
                                      Navigator.pushNamed(context, '/profile-user'),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Widget _list(BuildContext context) {
//   return ListView.builder(
//     itemBuilder: (context, index) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
//         child: FriendList(
//           color: const Color(0xffededed),
//           displayname: _friendlistDisplayname[index],
//           username: _friendlistUsername[index],
//           profilePicture: null,
//           onTap: () {},
//         ),
//       );
//     },
//     itemCount: _friendlistDisplayname.length,
//   );
// }
}
