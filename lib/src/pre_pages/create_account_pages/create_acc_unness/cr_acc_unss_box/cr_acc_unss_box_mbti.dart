import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_box.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_text.dart';

class CrAccUnssBoxMbti extends StatelessWidget {
  const CrAccUnssBoxMbti({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Column(
        children: [
          CrAccUnssBoxText(
            header: 'Which MBTI personality are you?',
          ),
          CrAccUnssBoxBox(/* TODO: DropDown MBTI */),
        ],
      ),
    );
  }
}
