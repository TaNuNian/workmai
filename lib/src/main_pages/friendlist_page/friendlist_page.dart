import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/src/decor/friend_list_tile.dart';
import 'package:workmai/src/main_pages/friendlist_page/add_friend_page.dart';

class FriendlistPage extends StatefulWidget {
  const FriendlistPage({super.key});

  @override
  State<FriendlistPage> createState() => _FriendlistPageState();
}

class _FriendlistPageState extends State<FriendlistPage> {
  final FriendService _friendService = FriendService();
  late Future<List<Map<String, dynamic>>> _friendsFuture;

  void initState() {
    super.initState();
    _friendsFuture = _friendService.fetchFriends();
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
        'FRIENDS',
        style: GoogleFonts.sarabun(
          color: const Color(0xff59A1B6),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddFriendPage()),
              );
            },
            icon: const Icon(
              Icons.person_add_outlined,
              color: Color(0xff59A1B6),
            ),
            iconSize: 30,
          ),
        )
      ],
      backgroundColor: Colors.transparent,
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.02,
          horizontal: MediaQuery.sizeOf(context).width * 0.05,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xffB8E175),
              strokeAlign: BorderSide.strokeAlignCenter,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _friendsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    margin: const EdgeInsets.only(top: 24),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Find your new friend !',
                      style: GoogleFonts.raleway(color: const Color(0xff8E8E8E), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  );
                } else {
                  final friends = snapshot.data!;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FriendList(
                          color: const Color(0xffededed),
                          displayname: friend['displayName'] ?? 'Display Name',
                          username: friend['name'],
                          profilePicture: friend['profilePicture'],
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => FriendProfilePage(uid: friend['uid']),
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                    itemCount: friends.length,
                  );
                }
              },
            ),
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
