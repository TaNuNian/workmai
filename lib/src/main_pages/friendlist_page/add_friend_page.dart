import 'package:flutter/material.dart';
import 'package:workmai/src/decor/search_tab.dart';
import 'package:workmai/src/decor/theme.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({super.key});

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
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.02,
          horizontal: MediaQuery.sizeOf(context).width * 0.05,
        ),
        child: Column(
          children: [
            CustomSearchTab(),
            Container(
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
            ),
          ],
        ),
      ),
    );
  }

}
