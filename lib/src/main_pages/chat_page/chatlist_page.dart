import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/chat_list.dart';
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
    'Display 01',
    'Display 02',
    'Display 03',
    'Display 04',
    'Display 05',
  ];

  final List<String> _chatlistFrRecentMsg = [
    'Message 01',
    'Message 02',
    'Message 03',
    'Message 04',
    'Message 05',
  ];

  final List<String> _chatlistCWDisplayname = [
    'Display 01',
    'Display 02',
    'Display 03',
    'Display 04',
    'Display 05',
  ];

  final List<String> _chatlistCWRecentMsg = [
    'Message 01',
    'Message 02',
    'Message 03',
    'Message 04',
    'Message 05',
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
        onPressed: () {},
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
        child: Column(
          children: [
            _tabBarSelectMode(context),
            TabBarView(
              controller: _tabController,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.85,
                  color: Colors.white,
                ),
                _listFriends(context),
                _listCoWorkers(context),
              ],
            ),
          ],
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

  Widget _listFriends(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ChatList(
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
        return ChatList(
          color: const Color(0xff9f9f9f),
          displayname: _chatlistCWDisplayname[index],
          recentMsg: _chatlistCWRecentMsg[index],
        );
      },
      itemCount: _chatlistCWDisplayname.length,
    );
  }

// Widget _selectMode(BuildContext context) {
//   return SizedBox(
//       height: MediaQuery.sizeOf(context).height * 0.15,
//       child: Row(
//         children: [
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {},
//               child: const Text('Friends'),
//             ),
//           ),
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {},
//               child: const Text('Co-Workers'),
//             ),
//           ),
//         ],
//       ),
//   );
// }
}
