import 'package:flutter/material.dart';
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

  final List<String> _friendlistDisplayname = [
    'Display 01',
    'Display 02',
    'Display 03',
    'Display 04',
    'Display 05',
  ];

  final List<String> _friendlistUsername = [
    'username01',
    'username02',
    'username03',
    'username04',
    'username05',
  ];

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode.unfocus();
    super.initState();
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
                    decoration: textfieldSearchDec('@'),
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
                child: _list(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _list(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          child: FriendList(
            color: const Color(0xffededed),
            displayname: _friendlistDisplayname[index],
            username: _friendlistUsername[index],
            profilePicture: null,
            onTap: () {},
          ),
        );
      },
      itemCount: _friendlistDisplayname.length,
    );
  }
}
