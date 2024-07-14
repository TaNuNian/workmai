import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/padding.dart';
import 'package:workmai/src/decor/search_tab.dart';
import 'package:workmai/src/decor/textfield_decor.dart';
import 'package:workmai/src/main_pages/home_page/home_page_wg/home_header.dart';
import 'package:workmai/src/main_pages/home_page/home_page_wg/home_topmatch_tile.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  List<Map<String, dynamic>> userList = [
    {'name': 'User 1', 'username': '@user1'},
    {'name': 'User 2', 'username': '@user2'},
    {'name': 'User 3', 'username': '@user3'},
    {'name': 'User 4', 'username': '@user4'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: SafeArea(
        child: Padding(
          padding: bodyHomePagePadding(context),
          child: Column(
            children: <Widget>[
              // Header
              const HomeHeader(),
              const SizedBox(height: 20),
              // Search Tab
              CustomSearchTab(
                child: Center(
                  child: TextField(
                    controller: _controller,
                    decoration: textfieldSearchDec('Search'),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // News
                    _news(context),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    // Top Match
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Top Match',
                          style: GoogleFonts.raleway(
                            color: const Color(0xff327B90),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // _listTopMatch(context),
              _listRecomended(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _news(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'News',
              style: GoogleFonts.raleway(
                color: const Color(0xffFFFFFF),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.01,
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.2,
          decoration: BoxDecoration(
            color: const Color(0xffCCCCCC),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }

  Widget _listRecomended(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: index == 0
                ? listCardZero(context, userList[index])
                : listCardnonZero(context, userList[index]),
          );
        },
      ),
    );
  }


}
