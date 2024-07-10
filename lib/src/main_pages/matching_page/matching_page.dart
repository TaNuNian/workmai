import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';
import 'package:workmai/src/main_pages/matching_page/startmatchbutton.dart';

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
      child: _firstPage(context, 1),
    );
  }

  // PageView _pageView(BuildContext context) {
  //   return PageView.builder(
  //     scrollDirection: Axis.vertical,
  //     controller: _pageController,
  //     itemBuilder: (context, position) {
  //       double opacity = 1.0 - (_currentPage - position).abs().clamp(0.0, 1.0);
  //       if (position == 0) {
  //         return _firstPage(context, opacity);
  //       } else {
  //         return _secondPage(context, opacity);
  //       }
  //     },
  //     itemCount: 2,
  //   );
  // }

  Widget _firstPage(BuildContext context, double opacity) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          _topFirstPage(context),
          const SizedBox(
            height: 10,
          ),
          _bodyFirstPage(context),
        ],
      ),
    );
  }

  Widget _topFirstPage(BuildContext context) {
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
              child: startMatchButton(context, '/match-recc-page'),
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
}
