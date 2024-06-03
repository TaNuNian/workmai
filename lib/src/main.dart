import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_2.dart';
import '../firebase_options.dart';
import '../routes.dart';
import 'decor/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: const LoginPage2(),
      routes: routes,
    );
  }
}
