import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/inter_tag.dart';
import 'package:workmai/src/main_pages/profile_pages/profile_wg/skill_tag.dart';

class TestLetMatch extends StatefulWidget {
  const TestLetMatch({super.key});

  @override
  _TestLetMatchState createState() => _TestLetMatchState();
}

class _TestLetMatchState extends State<TestLetMatch>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int? _selectedPeopleCount;
  int? _selectedAgeRange;
  bool _createGroup = false;
  bool _invite = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff327B90),
      appBar: AppBar(
        title: Text(
          "LET'S MATCHING",
          style: GoogleFonts.raleway(
              color: const Color(0xffFFFFFF),
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff327B90),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: const Color(0xffFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _tabBarSelectMode(context),
                Row(
                  children: [
                    DropdownButton<int>(
                      value: _selectedPeopleCount,
                      hint: Text(
                        'Person(s) (number)',
                        style: GoogleFonts.raleway(
                          color: const Color(0xff327B90),
                        ),
                      ),
                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text('${index + 1}'),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          _selectedPeopleCount = value;
                        });
                      },
                    ),
                    SizedBox(width: 16),
                    DropdownButton<int>(
                      value: _selectedAgeRange,
                      hint: Text(
                        'Age-Range',
                        style: GoogleFonts.raleway(
                          color: const Color(0xff327B90),
                        ),
                      ),
                      items: List.generate(5, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text(
                              '${(index + 1) * 10}-${(index + 1) * 10 + 9}'),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          _selectedAgeRange = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _createGroup,
                      onChanged: (value) {
                        setState(() {
                          _createGroup = value!;
                        });
                      },
                    ),
                    Text(
                      'Create Group',
                      style:
                          GoogleFonts.raleway(color: const Color(0xff327B90)),
                    ),
                    SizedBox(width: 16),
                    Checkbox(
                      value: _invite,
                      onChanged: (value) {
                        setState(() {
                          _invite = value!;
                        });
                      },
                    ),
                    Text(
                      'Invite',
                      style:
                          GoogleFonts.raleway(color: const Color(0xff327B90)),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SkillTag(skilledTags: []),
                SizedBox(height: 16),
                InterTag(interestedTags: []),
                SizedBox(height: 16),
                Text(
                  'Others',
                  style: GoogleFonts.raleway(
                      color: const Color(0xff327B90),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: const Color(0xffEFFED5),
                    filled: true,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Handle match now action
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xff327B90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'MATCH NOW',
                    style: GoogleFonts.raleway(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
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
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
