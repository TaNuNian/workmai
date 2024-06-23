import 'package:flutter/material.dart';
import 'package:workmai/model/account.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_widget/login_profile.dart';
import 'package:workmai/src/pre_pages/register_page/register_page_wg/register_body.dart';
import 'package:workmai/src/pre_pages/register_page/register_page_wg/register_children_wg.dart';
import 'package:workmai/src/pre_pages/register_page/register_page_wg/register_header_text.dart';
import 'register_page_wg/register_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  // final _formKey = GlobalKey<FormState>();
  List<String> profile = registerText;
  Account account = signupAccount;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .sizeOf(context)
        .width;
    double height = MediaQuery
        .sizeOf(context)
        .height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // Custom back icon
          onPressed: () {
            Navigator.pop(context); // Pop the current screen
          },
        ),
        toolbarHeight: 70,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.02,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery
                          .sizeOf(context)
                          .height * 0.6,
                      width: double.infinity,
                      // decoration: const BoxDecoration(color: Colors.red),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: RegisterChildren(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.05),
                      child: RegisterButton(account: account,formKey: _formKey,),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/create-account');
                      },
                      child: const Text('Bypass'),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}