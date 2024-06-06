import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:workmai/src/pages/home_page/home_page.dart';
// import 'package:workmai/src/pages/profile_page/profile_page.dart';
// import 'package:workmai/src/pages/search_page/search_page.dart';
// import 'package:workmai/src/pre_pages/login_page/login_page.dart';
// import 'package:workmai/src/pre_pages/name_bd_input_page/name_bd_input_page.dart';
// import 'package:workmai/src/pre_pages/login_page/login_page.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_2.dart';
import 'package:workmai/src/pre_pages/register_page/register_page.dart';

Map<String, WidgetBuilder> routes = {
  // '/home' : (context) => HomePage(),
  // '/profile' : (context) => ProfilePage(),
  // '/search' : (context) => SearchPage(),
  // '/inputnamebd' : (context) => NameBdInputPage(),
  // '/login': (context) => LoginPage(),
  '/login2': (context) => LoginPage2(),
  '/register': (context) => RegisterPage()
};