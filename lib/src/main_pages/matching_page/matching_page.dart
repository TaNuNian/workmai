import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({super.key});

  @override
  _MatchingPageState createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  late final PageController _pageController;
  double _currentPage = 0.0;
  String? _selectedCat;

  final List<String> _categoryDDList = [
    'Cat 01',
    'Cat 02',
    'Cat 03',
  ];

  final List<String> recommendedItems = [
    'Recommended Item 1',
    'Recommended Item 2',
    'Recommended Item 3',
    'Recommended Item 4',
  ];

  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page!;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      top: false,
      child: _pageView(context),
    );
  }

  PageView _pageView(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemBuilder: (context, position) {
        double opacity = 1.0 - (_currentPage - position).abs().clamp(0.0, 1.0);
        if (position == 0) {
          return _firstPage(context, opacity);
        } else {
          return _secondPage(context, opacity);
        }
      },
      itemCount: 2,
    );
  }

  Widget _firstPage(BuildContext context, double opacity) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          _topFirstPage(),
          const SizedBox(
            height: 10,
          ),
          _bodyFirstPage(context),
        ],
      ),
    );
  }

  Widget _topFirstPage() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.65,
      decoration: const BoxDecoration(
        gradient: mainLinearGradientReverse,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text
            Center(
              child: Text(
                'FIND YOUR\nCO-WORKERS',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: const Color(0xffFFFFFF),
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  shadows: [
                    const Shadow(
                      offset: Offset(0, 3),
                      color: Color(0xff505050),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),

            // Button
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: _startMatchButton(),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _bodyFirstPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'swipe up to see top users in each catagory',
        style: GoogleFonts.raleway(
          color: const Color(0xff327B90),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _secondPage(BuildContext context, double opacity) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          _topSecondPage(),
          _bodySecondPage(context),
        ],
      ),
    );
  }

  Widget _startMatchButton() {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffE5F1D3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Start Matching',
              style: GoogleFonts.raleway(
                color: const Color(0xff327B90),
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xff327B90),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topSecondPage() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 240,
      decoration: const BoxDecoration(
          color: Color(0xff327B90),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
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
                    child: _startMatchButton(),
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

  Widget _bodySecondPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              DropdownButton(
                value: _selectedCat,
                hint: Text(
                  'Select a category',
                  style: GoogleFonts.raleway(),
                ),
                items: _categoryDDList.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.raleway(),
                    ),
                  );
                }).toList(),
                onChanged: (String? _newvalue) {
                  setState(() {
                    _selectedCat = _newvalue;
                  });
                },
              )
            ],
          ),

          // List
          _listRecomended(context),
        ],
      ),
    );
  }

  _listRecomended(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 16.0, // horizontal spacing
        runSpacing: 16.0, // vertical spacing
        children: List.generate(recommendedItems.length, (index) {
          return Container(
            width: (MediaQuery.of(context).size.width - 64) /
                2, // 2 columns with spacing
            decoration: BoxDecoration(
              color: const Color(0xff67B4CA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40),
                ),
                SizedBox(height: 10),
                Text(
                  recommendedItems[index],
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '@cofinder',
                  style: GoogleFonts.raleway(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '#C #Computer #Software',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        }),
      ),
    );
  }
}
