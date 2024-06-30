import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/friend_list.dart';
import 'package:workmai/src/main_pages/friendlist_page/add_friend_page.dart';

class FriendlistPage extends StatefulWidget {
  const FriendlistPage({super.key});

  @override
  State<FriendlistPage> createState() => _FriendlistPageState();
}

class _FriendlistPageState extends State<FriendlistPage> {
  List<String> _friendlistDisplayname = [
    'Display 01',
    'Display 02',
    'Display 03',
    'Display 04',
    'Display 05',
  ];

  List<String> _friendlistUsername = [
    'username01',
    'username02',
    'username03',
    'username04',
    'username05',
  ];

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
            child: _list(context),
          ),
        ),
      ),
    );
  }

  Widget _list(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return FriendList(
          color: const Color(0xff9f9f9f),
          displayname: _friendlistDisplayname[index],
          username: _friendlistUsername[index],
        );
      },
      itemCount: _friendlistDisplayname.length,
    );

  }
}
