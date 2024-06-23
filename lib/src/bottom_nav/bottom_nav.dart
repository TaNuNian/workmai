import 'package:flutter/material.dart';
import 'package:workmai/src/main_pages/friendlist_page/friendlist_page.dart';
import 'package:workmai/src/main_pages/home_page/home_page.dart';
import 'package:workmai/src/main_pages/profile_pages/my_profile_wg/myprofile_appear_edit.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    Text('Matching Placeholder'),
    FriendlistPage(),
    ProfilePage(
      button: MyprofileAppearEdit(),
    ),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  BottomNavigationBar BottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: const Color(0xff80e3ff),
      unselectedItemColor: const Color(0xff67B4CA),
      onTap: onItemTapped,
      elevation: 0,
      iconSize: 32,
      items: List.generate(
        _pages.length,
        (index) => BottomNavigationBarItem(
          icon: _selectedIndex == index
              ? selectedIcon[index]
              : unselectedIcon[index],
          label: '',
        ),
      ),
    );
  }

  List<Icon> unselectedIcon = const [
    Icon(Icons.home_outlined),
    Icon(Icons.person_search_outlined),
    Icon(Icons.chat_outlined),
    Icon(Icons.person_outline),
  ];
  List<Icon> selectedIcon = const [
    Icon(Icons.home),
    Icon(Icons.person_search),
    Icon(Icons.chat),
    Icon(Icons.person),
  ];
}
