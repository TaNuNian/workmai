import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_box.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_text.dart';

class CrAccUnssBoxTime extends StatefulWidget {
  const CrAccUnssBoxTime({super.key});

  @override
  _CrAccUnssBoxTimeState createState() => _CrAccUnssBoxTimeState();
}

class _CrAccUnssBoxTimeState extends State<CrAccUnssBoxTime> {

  final List<String> activeTime = [
    '6:00 - 9:00 น.',
    '9:00 - 12:00 น.',
    '12:00 - 15:00 น.',
    '15:00 - 18:00 น.',
    '18:00 - 21:00 น.',
    '21:00 - 24:00 น.',
    '24:00 - 3:00 น.',
    '3:00 - 6:00 น.',
  ];

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Column(
        children: [
          const CrAccUnssBoxText(
            header: 'What times do you feel enthusiastic and energized?',
          ),
          CrAccUnssBoxBox(
            child: MultiSelectDialogField(
              items: activeTime.map((time) => MultiSelectItem(time, time)).toList(),
              title: const Text("Active Time"),
              selectedColor: Colors.blue,
              decoration: BoxDecoration(
                color: const Color(0xffE5F1D3),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: const Color(0xffE5F1D3),
                  width: 2,
                ),
              ),
              buttonIcon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              buttonText: Text(
                "Select Your Active Time",
                style: GoogleFonts.sarabun(
                  color: Colors.black45,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              onConfirm: (results) {
                setState(() {
                  profileProvider.profile.active_time = results.cast<String>();
                });
                print(profileProvider.profile.active_time);
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (value) {
                  setState(() {
                    profileProvider.profile.active_time?.remove(value);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
