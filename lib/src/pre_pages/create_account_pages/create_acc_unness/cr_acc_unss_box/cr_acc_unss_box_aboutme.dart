import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cr_acc_unss_box_text.dart';

class CrAccUnssBoxAboutme extends StatefulWidget {
  const CrAccUnssBoxAboutme({super.key});

  @override
  State<CrAccUnssBoxAboutme> createState() => _CrAccUnssBoxAboutmeState();
}

class _CrAccUnssBoxAboutmeState extends State<CrAccUnssBoxAboutme> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Column(
        children: [
          CrAccUnssBoxText(
              header:
                  "Is there anything else you'd care to share about yourself"),
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField( // TODO: TextField max 4-5 lines
                // controller: _controller,
                maxLines: 4,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
