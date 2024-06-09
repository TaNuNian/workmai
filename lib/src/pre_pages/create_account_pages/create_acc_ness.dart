import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/custom_appbar/custom_appbar.dart';
import 'package:workmai/src/decor/continue_button.dart';
import 'package:workmai/src/decor/gradient_box.dart';
import 'package:workmai/src/decor/padding.dart';
import 'create_acc_wg/create_acc_textbox.dart';

class CreateAccNess extends StatefulWidget {
  const CreateAccNess({super.key});

  @override
  _CreateAccNessState createState() => _CreateAccNessState();
}

class _CreateAccNessState extends State<CreateAccNess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    GradientBox(
                      height: MediaQuery.sizeOf(context).height * 0.75,
                    ),
                    Padding(
                      padding: bodyPadding(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          customBackButton(),
                          UsernameTextbox(
                            hint: 'Username',
                            type: 'Username',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const ContinueButton(
                  actionName: 'ต่อไป',
                  routeName: '/', // Here you can specify the route or action for the continue button
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customBackButton() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            size: 40.0,
            color: Color(0xffffffff),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
