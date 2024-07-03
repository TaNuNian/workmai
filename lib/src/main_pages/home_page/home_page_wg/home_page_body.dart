import 'package:flutter/material.dart';
import 'package:workmai/src/decor/padding.dart';
import 'package:workmai/src/decor/search_tab.dart';
import 'package:workmai/src/decor/textfield_decor.dart';
import 'package:workmai/src/main_pages/home_page/home_page_wg/home_header.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  String hint = 'Search';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
                    decoration: textfieldSearchDec(hint),
                  ),
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
