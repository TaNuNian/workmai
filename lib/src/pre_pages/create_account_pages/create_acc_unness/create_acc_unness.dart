import 'package:flutter/material.dart';
import 'package:workmai/src/custom_appbar/custom_appbar.dart';
import 'package:workmai/src/decor/finish_button.dart';
import 'package:workmai/src/decor/gradients.dart';
import 'package:workmai/src/decor/padding.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_aboutme.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_mbti.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_time.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness/cr_acc_unss_box/cr_acc_unss_box_wstyle.dart';

class CreateAccUnness extends StatefulWidget {
  const CreateAccUnness({super.key});

  @override
  _CreateAccUnnessState createState() => _CreateAccUnnessState();
}

class _CreateAccUnnessState extends State<CreateAccUnness> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: mainLinearGradient,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: bodyPadding(context),
                child: Column(
                  children: [
                    const CustomAppbar(
                      appbarColor: Colors.transparent,
                    ),
                    const CrAccUnssBoxMbti(),
                    const CrAccUnssBoxTime(),
                    const CrAccUnssBoxWstyle(),
                    CrAccUnssBoxAboutme(
                      controller: controller,
                    ),
                    const FinishButton(
                      routeName: '/home',
                      actionName: 'Finish!',
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
