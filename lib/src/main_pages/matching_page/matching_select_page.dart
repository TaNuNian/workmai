import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';
import 'package:workmai/src/decor/tags.dart';
import 'package:workmai/src/decor/theme.dart';
import 'package:workmai/src/main_pages/matching_page/matching_result.dart';
import 'package:workmai/src/main_pages/matching_page/select_matching_tags/selected_tags_page.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/inter_tag.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/skill_tag.dart';
import 'package:cloud_functions/cloud_functions.dart';

class MatchingSelectPage extends StatefulWidget {
  const MatchingSelectPage({super.key});

  @override
  _MatchingSelectPageState createState() => _MatchingSelectPageState();
}

class _MatchingSelectPageState extends State<MatchingSelectPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;

  TextEditingController _amountController = TextEditingController();
  RangeValues ageRange = const RangeValues(18, 30);
  String? selectedGender;
  List<String> selectedInterestTags = [];
  List<String> selectedSkillTags = [];
  bool createGroup = false;
  bool invite = false;
  bool openLowerRank = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
                      _rowDropdowns(context),
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

  Widget _rowDropdowns(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          // Dropdown Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Amount
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    hintStyle: _hintStyle(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      if (int.tryParse(value) != null && int.parse(value) > 0) {
                        // Valid amount
                      } else {
                        // Invalid amount, handle accordingly
                        _amountController.clear();
                      }
                    });
                  },
                ),
              ),

              // Age
              Column(
                children: [
                  Text(
                    'Age range',
                    style: _hintStyle(),
                  ),
                  RangeSlider(
                    values: ageRange,
                    min: 18,
                    max: 60,
                    divisions: 42,
                    labels: RangeLabels(
                      '${ageRange.start.round()}',
                      '${ageRange.end.round()}',
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        ageRange = values;
                      });
                    },
                  ),
                ],
              ),

              // Gender
              DropdownButton<String>(
                value: selectedGender,
                hint: Text(
                  'Gender',
                  style: _hintStyle(),
                ),
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
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
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectTagsPage(isInterested: true),
                ),
              );
              if (result != null) {
                setState(() {
                  selectedInterestTags = result;
                });
              }
            },
            child: InterTag(interestedTags: selectedInterestTags),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectTagsPage(isInterested: false),
                ),
              );
              if (result != null) {
                setState(() {
                  selectedSkillTags = result;
                });
              }
            },
            child: SkillTag(skilledTags: selectedSkillTags),
          ),
        ],
      ),
    );
  }

  Widget _checkboxList(BuildContext context) {
    return Column(
      children: [
        _checkBox(context, 'Create Group', createGroup, (value) {
          setState(() {
            createGroup = value ?? false;
          });
        }),
        _checkBox(context, 'Invite', invite, (value) {
          setState(() {
            invite = value ?? false;
          });
        }),
        _checkBox(context, 'Open Lower Rank', openLowerRank, (value) {
          setState(() {
            openLowerRank = value ?? false;
          });
        }),
      ],
    );
  }

  Widget _checkBox(BuildContext context, String checkText, bool value, Function(bool?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
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
                fontWeight: FontWeight.bold,
              ),
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
          onPressed: () async {
            int? amount = int.tryParse(_amountController.text);

            if (amount != null && amount > 0) {
              // เรียกใช้ฟังก์ชั่น cloud function
              HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('matchUsers');
              final results = await callable.call({
                'userId': 'currentUserUid', // ใส่ userId ที่ต้องการ
                'mode': _tabController.index == 0 ? 'friends' : 'coworkers',
                'ageRange': [ageRange.start.round(), ageRange.end.round()],
                'gender': selectedGender,
                'interestTags': selectedInterestTags,
                'skillTags': selectedSkillTags,
                'rank': 'userRank', // ใส่ rank ของผู้ใช้
                'openLowerRank': openLowerRank,
              });

              // จัดการผลลัพธ์ที่ได้รับจาก cloud function
              List<dynamic> matchedUsers = results.data['matchedUsers'];

              // แสดงผล matched users หรือทำการเปลี่ยนหน้า
              // ตัวอย่างการเปลี่ยนหน้าและส่งข้อมูล
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MatchingResultPage(matchedUsers: matchedUsers),
                ),
              );
            } else {
              // แสดงข้อความแสดงข้อผิดพลาดถ้าจำนวนไม่ถูกต้อง
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please enter a valid amount'),
                ),
              );
            }
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
