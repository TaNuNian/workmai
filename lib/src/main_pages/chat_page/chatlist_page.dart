import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/chat_list_tile.dart';
import 'package:workmai/src/decor/padding.dart';
import 'package:workmai/src/decor/theme.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> _chatlistFrDisplayname = [
    'DisplayFriend 01',
    'DisplayFriend 02',
    'DisplayFriend 03',
    'DisplayFriend 04',
    'DisplayFriend 05',
  ];

  final List<String> _chatlistFrRecentMsg = [
    'abc',
    'def',
    'ghi',
    'jkl',
    'mnl',
  ];

  final List<String> _chatlistCWDisplayname = [
    'Display 01',
    'Display 02',
    'Display 03',
    'Display 04',
    'Display 05',
  ];

  final List<String> _chatlistCWRecentMsg = [
    'pqr',
    'stu',
    'yw',
    'xy',
    'zab',
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor(),
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  Color _backgroundColor() {
    return const Color(0xff327B90);
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xffffffff)),
        iconSize: 28,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'CHATS',
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
        child: Center(
          child: Column(
            children: [
              _tabBarSelectMode(context),
              _useList(context),
            ],
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
          child: Text('Friends'),
        ),
        Tab(
          child: Text('Co-Workers'),
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
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      onTap: (index) {
        print('Selected Tab: $index');
      },
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
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(
                  child: _listFriends(context),
                ),
                Center(
                  child: _listCoWorkers(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listFriends(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ChatListTile(
          color: const Color(0xff9f9f9f),
          displayname: _chatlistFrDisplayname[index],
          recentMsg: _chatlistFrRecentMsg[index],
        );
      },
      itemCount: _chatlistFrDisplayname.length,
    );
  }

  Widget _listCoWorkers(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ChatListTile(
          color: const Color(0xff9f9f9f),
          displayname: _chatlistCWDisplayname[index],
          recentMsg: _chatlistCWRecentMsg[index],
        );
      },
      itemCount: _chatlistCWDisplayname.length,
    );
  }

  EdgeInsets _listInsets() {
    return const EdgeInsets.symmetric(vertical: 36, horizontal: 24);
  }
}
