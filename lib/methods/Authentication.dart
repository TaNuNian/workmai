import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmai/model/account.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> signUp(Profile profile) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: profile.email,
      password: profile.password,
    );
    print("User signed up: ${userCredential.user?.uid}");
  } catch (e) {
    print(e);
  }
}

Future<void> signIn(Profile profile) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: profile.email,
      password: profile.password,
    );
  } catch (e) {
    print(e);
  }
}
