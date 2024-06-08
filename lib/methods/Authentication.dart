import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workmai/model/account.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> signUp(BuildContext context, Account account) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: account.email,
      password: account.password,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign Up Successful!')),
    );
    print("User signed up: ${userCredential.user?.uid}");
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    if (e.code == 'email-already-in-use') {
      errorMessage = 'The email address is already in use by another account.';
    } else {
      errorMessage = 'Failed to sign up: ${e.message}';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  } catch (e) {
    // Display error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('An unexpected error occurred. Please try again.')),
    );
  }
}

Future<void> signIn(BuildContext context, Account account) async {
  try {
    print("User signed in: ${account.email} and password: ${account.password}");
    await _auth.signInWithEmailAndPassword(
      email: account.email,
      password: account.password,
    );
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => RegisterPage(),
    //     ));
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
      SnackBar(
          content: Text('An unexpected error occurred. Please try again.')),
    );
  }
}