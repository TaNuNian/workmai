import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/user_provider.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/pre_pages/login_page/login_page_2.dart';
import 'firebase_options.dart';
import 'routes.dart';
import 'src/decor/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()..fetchUserData()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme,
        home: const LoginPage2(),
        // home: StreamBuilder<User?>(
        //   stream: FirebaseAuth.instance.onAuthStateChanged(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return const Homepage();
        //     } else {
        //       return const LoginPage2();
        //     }
        //   },
        // )
        routes: routes,
      ),
    );
  }
}
