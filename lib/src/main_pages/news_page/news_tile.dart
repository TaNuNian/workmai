import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTile extends StatelessWidget {
  final String newsTitle;
  final String detail;
  final bool? isOnsite;

  const NewsTile({
    super.key,
    required this.newsTitle,
    required this.detail,
    this.isOnsite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xffEFFED5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Banner
          Expanded(
            flex: 2,
            child: Container(
              height: 1,
            ),
          ),
          // Text
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        newsTitle,
                        style: GoogleFonts.raleway(
                            color: const Color(0xff327B90),
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xff327B90),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isOnsite == true ? 'ONSITE' : 'ONLINE',
                          style: GoogleFonts.raleway(
                              color: const Color(0xffFFFFFF),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        detail,
                        style: GoogleFonts.raleway(
                            color: const Color(0xff55B18D),
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
