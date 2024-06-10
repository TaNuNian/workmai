import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_intro.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/create_acc_ness.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_unness_intro.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_2.dart';
import 'package:workmai/src/pre_pages/register_page/register_page.dart';

Map<String, WidgetBuilder> routes = {
  // '/home' : (context) => HomePage(),
  '/login2': (context) => const LoginPage2(),
  '/register': (context) => const RegisterPage(),
  '/create-account' : (context) => const CreateAccIntro(),
  '/create-acc-ness' : (context) => const CreateAccNess(),
  '/create-acc-unness-intro' : (context) => SelectAbilitiesScreen(),
};