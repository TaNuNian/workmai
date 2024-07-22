import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/user_provider.dart';
import 'package:workmai/src/decor/chip.dart';

class FolioWorks extends StatelessWidget {
  final bool? isEdit;

  const FolioWorks({
    super.key,
    this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    double dimension1 = 200;
    double dimension2 = 120;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.01,
        horizontal: MediaQuery.sizeOf(context).width * 0.02,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WORKS',
                  style: GoogleFonts.raleway(
                    color: const Color(0xff327B90),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _pics(context, dimension1),
          const SizedBox(
            height: 10,
          ),
          _docs(context, dimension2),
          const SizedBox(
            height: 10,
          ),
          _links(context, dimension2),
        ],
      ),
    );
  }

  Widget _pics(BuildContext context, double dimension1) {
    return SizedBox(
      height: dimension1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: dimension1 / 9 * 16,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffA9A9A9),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _docs(BuildContext context, double dimension2) {
    return SizedBox(
      height: dimension2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: dimension2 / 9 * 16,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffB6E7D3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _links(BuildContext context, double dimension2) {
    return SizedBox(
      height: dimension2 * 0.8,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'link ${index + 1}',
              style: GoogleFonts.raleway(
                  color: const Color(0xff6DD484),
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          );
        },
      ),
    );
  }
}
