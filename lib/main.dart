// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmai/methods/cloud_firestore/profile_picker.dart';
import 'package:workmai/methods/user_provider.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/main_pages/profile_pages/friend_profile.dart';
import 'package:workmai/src/main_pages/profile_pages/user_profile.dart';
import 'package:workmai/src/pre_pages/login_page/splash_screen.dart';
import 'firebase_options.dart';
import 'routes.dart';
import 'src/decor/theme.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // statusBarColor: Color(0xff103240),
    statusBarBrightness: Brightness.light,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.playIntegrity,
  //   appleProvider: AppleProvider.deviceCheck,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserProvider()..fetchUserData()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => UploadProfile()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme,
        home: SplashScreen(),
        routes: routes,
        onGenerateRoute: (settings) {
          if (settings.name == '/profile-other') {
            final String uid = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => UserProfile(uid: uid),
            );
          }
          if (settings.name == '/profile-friends') {
            final String uid = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => FriendsProfile(uid: uid),
            );
          }

          return null; // Let `MaterialApp` handle the routes
        },
      ),
    );
  }
}
