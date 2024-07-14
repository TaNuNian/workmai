import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/chat_list_tile.dart';
import 'package:workmai/src/decor/continue_button.dart';
import 'package:workmai/src/decor/gradients.dart';
import 'package:workmai/src/decor/theme.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/inter_tag.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/skill_tag.dart';

class MatchingSelectPage extends StatefulWidget {
  const MatchingSelectPage({super.key});

  @override
  _MatchingSelectPageState createState() => _MatchingSelectPageState();
}

class _MatchingSelectPageState extends State<MatchingSelectPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;

  // For testing
  final List<DropdownMenuEntry<int>> _amount = List.generate(5, (index) {
    return DropdownMenuEntry<int>(value: index + 1, label: '${index + 1}');
  });

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor(),
      appBar: _appbar(context),
      body: _body(context, _amount),
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

  Widget _body(BuildContext context, List<DropdownMenuEntry<int>> amount){
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              tabBarSelectMode(context),
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffFFFFFF),
                    ),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.sizeOf(context).height * 0.9,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      _rowDropdowns(context, amount),
                      interskill(),
                      _checkboxList(context),
                      const SizedBox(height: 20,),
                      _matchButton(context),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabBarSelectMode(BuildContext context) {
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
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _rowDropdowns(
      BuildContext context, List<DropdownMenuEntry<int>> amount) {
    int? selectedAmount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          // Dropdown Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Amount
              DropdownButton<int>(
                value: selectedAmount,
                hint: Text(
                  'Amount',
                  style: _hintStyle(),
                ),
                items: List.generate(5, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('Item ${index + 1}'),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    selectedAmount = value;
                  });
                },
                dropdownColor: const Color(0xffFFFFFF),
                elevation: 0,
              ),

              // Age
              DropdownButton<int>(
                value: selectedAmount,
                hint: Text(
                  'Age range',
                  style: _hintStyle(),
                ),
                items: List.generate(5, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('Item ${index + 1}'),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    selectedAmount = value;
                  });
                },
                dropdownColor: const Color(0xffFFFFFF),
                elevation: 0,
              ),

              // Gender
              DropdownButton<int>(
                value: selectedAmount,
                hint: Text(
                  'Gender',
                  style: _hintStyle(),
                ),
                items: List.generate(5, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('Item ${index + 1}'),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    selectedAmount = value;
                  });
                },
                dropdownColor: const Color(0xffFFFFFF),
                elevation: 0,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget interskill() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          InterTag(interestedTags: []), // TODO
          SkillTag(skilledTags: []),
        ],
      ),
    );
  }

  Widget _checkboxList(BuildContext context) {
    return Column(
      children: [
        _checkBox(context, 'Create Group'),
        _checkBox(context, 'Rank'),
        _checkBox(context, 'Invite'),
      ],
    );
  }

  Widget _checkBox(BuildContext context, String checkText) {
    bool _isChecked = false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Checkbox(
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              }),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xff327B90),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              checkText,
              style: GoogleFonts.raleway(
                  color: const Color(0xffFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  TextStyle _hintStyle() {
    return GoogleFonts.raleway(
      color: const Color(0xff327B90),
      fontSize: 20,
    );
  }

  Widget _matchButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * 0.08,
        decoration: BoxDecoration(
          gradient: crossLinearGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/match-result-page');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'MATCH NOW',
              style: GoogleFonts.raleway(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
