import 'package:flutter/material.dart';
import 'package:workmai/src/decor/continue_button.dart';
import 'package:workmai/src/decor/gradient_box.dart';
import 'package:workmai/src/decor/padding.dart';
import 'create_acc_birthday.dart';
import 'create_acc_textbox.dart';

class CreateAccNess extends StatefulWidget {
  const CreateAccNess({super.key});

  @override
  _CreateAccNessState createState() => _CreateAccNessState();
}

class _CreateAccNessState extends State<CreateAccNess> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                              controller: nameController,
                            ),
                            CreateAccBirthday(
                              controller: birthdateController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ContinueButton(
                    actionName: 'ต่อไป',
                    formKey: _formKey,
                    routeName: '/create-acc-inter',
                    funcCheckUsernameBD: true,
                  ),
                ],
              ),
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
