import 'package:flutter/material.dart';
import 'package:workmai/src/custom_appbar/custom_appbar.dart';
import 'package:workmai/src/decor/continue_button.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: mainLinearGradient,
              ),
            ),
            Padding(
              padding: bodyPadding(context),
              child: Column(
                children: [
                  CustomAppbar(
                    appbarColor: Colors.transparent,
                  ),
                  CrAccUnssBoxMbti(),
                  CrAccUnssBoxTime(),
                  CrAccUnssBoxWstyle(),
                  CrAccUnssBoxAboutme(),
                  ContinueButton(
                    routeName: '/home',
                    actionName: 'Finish!',
                    shouldCallFunction: false,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
