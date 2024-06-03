import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

Future<void> signIn(BuildContext context, Profile profile) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: profile.email,
      password: profile.password,
    );
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    if (e.code == 'user-not-found') {
      print(e.code);
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      print(e.code);
      errorMessage = 'Wrong password provided.';
    } else {
      print(e.code);
      errorMessage = 'An error occurred. Please try again.';
    }
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred. Please try again.')),
    );
  }
}
