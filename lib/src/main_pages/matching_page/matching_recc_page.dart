import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/main_pages/matching_page/startmatchbutton.dart';

class MatchingReccPage extends StatefulWidget {
  MatchingReccPage({super.key});

  @override
  State<MatchingReccPage> createState() => _MatchingReccPageState();
}

class _MatchingReccPageState extends State<MatchingReccPage> {
  final List<String> recommendedItems = [
    'Recommended 1',
    'Recommended 2',
    'Recommended 3',
    'Recommended 4',
    'Recommended 5',
    'Recommended 6',
    'Recommended 7',
    'Recommended 8',
    'Recommended 9',
  ];

  final List<String> categories = ['Category 1', 'Category 2', 'Category 3'];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff327B90),
      body: _body(context),
    );
  }

  Widget _appbar(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 240,
      decoration: const BoxDecoration(
          color: Color(0xff327B90),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Text
            Text(
              'FIND YOUR CO-WORKERS',
              style: GoogleFonts.raleway(
                color: const Color(0xffFFFFFF),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, bottom: 30, right: 20),
                    child: startMatchButton(context, '/match-select-page'),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffE5F1D3),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 32,
                    ),
                    onPressed: () {}, // TODO: Search Button
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xffFFFFFF),
        child: Center(
          child: Column(
            children: [
              _appbar(context),
              _categoryDropdown(context),
              Expanded(child: _listRecomended(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryDropdown(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, top: 12, bottom: 12),
          child: DropdownButton<String>(
            value: selectedCategory,
            hint: Text(
              'Category',
              style: GoogleFonts.raleway(
                color: const Color(0xff327B90),
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            items: categories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              selectedCategory = newValue; // TODO: Change Category
            },
          ),
        ),
      ],
    );
  }

  Widget _listRecomended(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: List.generate(
            recommendedItems.length,
            (index) {
              return _listCard(context, index);
            },
          ),
        ),
      ),
    );
  }

  Widget _listCard(BuildContext context, int index) {
    return Container(
      width: (MediaQuery.of(context).size.width - 64) / 2,
      decoration: BoxDecoration(
        color: const Color(0xff67B4CA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recommendedItems[index],
                      style: GoogleFonts.raleway(
                        color: const Color(0xffffffff),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '@username',
                      style: GoogleFonts.raleway(
                        color: const Color(0xffffffff),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xff2A4B54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '#sjuildfg #sdfasfas #sds',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.raleway(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
