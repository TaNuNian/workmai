import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_box.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_text.dart';

class CrAccUnssBoxTime extends StatelessWidget {
  const CrAccUnssBoxTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Column(
        children: [
          CrAccUnssBoxText(header: 'What times do you feel enthusiastic and energized?'),
          CrAccUnssBoxBox(/* TODO: DropDown Time */),
        ],
      ),
    );
  }
}
