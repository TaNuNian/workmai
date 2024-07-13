import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  double? now = 1;
  double? max = 1;

  String? reason = 'Reason';
  int? scoring = -5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: body(context),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: const BackButton(
        color: Color(0xffFFFFFF),
      ),
      title: Text(
        'RANK',
        style: GoogleFonts.raleway(
          color: const Color(0xffFFFFFF),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xff327B90),
    );
  }

  Widget body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            _levelGauge(context),
            const SizedBox(height: 24),
            _history(context),
          ],
        ),
      ),
    );
  }

  Widget _levelGauge(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffEFFED5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.military_tech_outlined,
                        color: Color(0xff327B90),
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'RankName',
                        style: GoogleFonts.raleway(
                            color: const Color(0xff327B90),
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 4,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: const Color(0xffAEAEAE),
                      borderRadius: BorderRadius.circular(1),
                    ),
                    child: Container(
                      height: 4,
                      width: double.maxFinite * (now! / max!), // TODO
                      decoration: BoxDecoration(
                        color: const Color(0xff327B90),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _history(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffEFFED5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.history,
                          color: Color(0xff327B90),
                          size: 32,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'History',
                          style: GoogleFonts.raleway(
                              color: const Color(0xff327B90),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  _historylist(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _historylist(BuildContext context) {
    return Expanded(
      flex: 9,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 4, right: 4),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reason',
                      style: GoogleFonts.raleway(
                        color: scoring! < 0
                            ? const Color(0xffed0b0b)
                            : const Color(0x0036f45d),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '-5',
                      style: GoogleFonts.raleway(
                        color: scoring! < 0
                            ? const Color(0xffed0b0b)
                            : const Color(0x0036f45d),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
