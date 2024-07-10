import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/chat_list_tile.dart';
import 'package:workmai/src/decor/theme.dart';

class MatchingSelectPage extends StatefulWidget {
  const MatchingSelectPage({super.key});

  @override
  _MatchingSelectPageState createState() => _MatchingSelectPageState();
}

class _MatchingSelectPageState extends State<MatchingSelectPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor(),
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  Color _backgroundColor() {
    return const Color(0xff327B90);
  }

  _appbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xffffffff)),
        iconSize: 28,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "LET'S MATCHING",
        style: appBarTitleStyle(const Color(0xffffffff)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            iconSize: 32,
            color: const Color(0xffffffff),
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.sizeOf(context).height * 0.02,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                _tabBarSelectMode(context),
                _useList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBarSelectMode(BuildContext context) {
    return TabBar(
      controller: _tabController,
      tabs: const <Widget>[
        Tab(
          child: Text('Find Friends'),
        ),
        Tab(
          child: Text('Find Co-Workers'),
        ),
      ],
      dividerColor: const Color(0xffffffff),
      indicator: const BoxDecoration(
        color: Colors.white,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: const Color(0xff327B90),
      unselectedLabelColor: const Color(0xffffffff),
      labelStyle: GoogleFonts.raleway(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _useList(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.white,
          ),
          Padding(
            padding: _listInsets(),
            child: Column(
              children: [
                // Dropdown Row
                Row(
                  children: [
                    //   DropdownButton(
                    //     value: List.generate(4, (index) => index),
                    //     hint: Text('Amout of People(s)',
                    //       style: GoogleFonts.raleway(color: const Color(0xff327B90)),
                    //       items: [],
                    //       onChanged:,)
                    //   ],
                    // )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  EdgeInsets _listInsets() {
    return const EdgeInsets.symmetric(vertical: 36, horizontal: 24);
  }
}
