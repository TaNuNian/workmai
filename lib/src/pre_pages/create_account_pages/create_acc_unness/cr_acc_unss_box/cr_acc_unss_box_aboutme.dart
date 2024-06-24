import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/profile_provider.dart';

import 'cr_acc_unss_box_text.dart';

class CrAccUnssBoxAboutme extends StatefulWidget {
  final TextEditingController controller;

  const CrAccUnssBoxAboutme({
    super.key,
    required this.controller,
  });

  @override
  State<CrAccUnssBoxAboutme> createState() => _CrAccUnssBoxAboutmeState();
}

class _CrAccUnssBoxAboutmeState extends State<CrAccUnssBoxAboutme> {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Column(
        children: [
          const CrAccUnssBoxText(
              header:
                  "Is there anything else you'd care to share about yourself"),
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget.controller,
                style: GoogleFonts.sarabun(
                    color: Colors.black45,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    height: 1.2),
                onChanged: (value){
                  profileProvider.setAboutme(value);
                },
                maxLines: 4,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
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
