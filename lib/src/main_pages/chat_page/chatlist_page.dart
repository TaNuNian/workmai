import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/cloud_firestore/co_worker_service.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';
import 'package:workmai/src/decor/chat_list_tile.dart';
import 'package:workmai/src/decor/theme.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final FriendService _friendService = FriendService();
  final CoWorkerService _coWorkerService = CoWorkerService();
  late Future<List<Map<String, dynamic>>> _friendsFuture;
  late Future<List<Map<String, dynamic>>> _coWorkersFuture;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _friendsFuture = _friendService.fetchFriends();
    _coWorkersFuture = _coWorkerService.fetchCoWorkers();
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
      floatingActionButton: _floatingActionButton(),
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
                  child: _futureList(context, _friendsFuture, true),
                ),
                Center(
                  child: _futureList(context, _coWorkersFuture, false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _futureList(BuildContext context, Future<List<Map<String, dynamic>>> future, bool isFriend) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: future,
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
              'No chats available!',
              style: GoogleFonts.raleway(
                  color: const Color(0xff8E8E8E),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          );
        } else {
          final items = snapshot.data!;
          return ListView.builder(
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChatListTile(
                  color: const Color(0xff9f9f9f),
                  uid: item['uid'],
                  isFriend: isFriend,
                ),
              );
            },
            itemCount: items.length,
          );
        }
      },
    );
  }

  EdgeInsets _listInsets() {
    return const EdgeInsets.symmetric(vertical: 36, horizontal: 24);
  }
  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      shape: const CircleBorder(),
      backgroundColor: const Color(0xff327B90),
      child: const Center(
        child: Icon(Icons.add, size: 28, color: Colors.white,),
      ),
    );
  }
}
