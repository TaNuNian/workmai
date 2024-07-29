import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workmai/src/main_pages/chat_page/chatlist_page.dart';
import 'package:workmai/src/main_pages/home_page/home_page.dart';
import 'package:workmai/src/main_pages/matching_page/matching_page.dart';
import 'package:workmai/src/main_pages/profile_pages/my_profile.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_page.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/myprofile_appear_edit.dart';
import 'package:workmai/src/main_pages/temp/web_board_list_page.dart';
import 'package:workmai/src/main_pages/webboard_page/web_board_list_page.dart';

class BottomNav extends StatefulWidget {
  final int? indexSelect;

  const BottomNav({super.key, this.indexSelect});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int? _indexSelect;

  @override
  void initState() {
    super.initState();
    _indexSelect = widget.indexSelect ?? 0; // Initialize with indexSelect or default to 0
  }

  void onItemTapped(int index) {
    setState(() {
      _indexSelect = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      const HomePage(),
      const ChatListPage(),
      const MatchingPage(),
      const WebBoardListPage(),
      const MyProfile(),
    ];

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Center(
          child: pages.elementAt(_indexSelect ?? 0),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  BottomNavigationBar BottomNavBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _indexSelect ?? 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xff67B4CA),
    unselectedItemColor: const Color(0xff67B4CA),
    onTap: onItemTapped,
    elevation: 0,
    iconSize: 32,
    items: List.generate(
      // _pages.length,
      unselectedIcon.length,
          (index) => BottomNavigationBarItem(
        icon: _indexSelect == index
            ? selectedIcon[index]
            : unselectedIcon[index],
        label: '',
      ),
    ),
    );
  }

  List<Widget> unselectedIcon = const [
    Icon(Icons.home_outlined),
    Icon(Icons.chat_outlined),
    Icon(Icons.compare_arrows_outlined),
    Icon(Icons.topic_outlined),
    Icon(Icons.person_outline),
  ];
  List<Widget> selectedIcon = const [
    Icon(Icons.home),
    Icon(Icons.chat),
    Icon(Icons.compare_arrows_rounded),
    Icon(Icons.topic),
    Icon(Icons.person),
  ];
}
