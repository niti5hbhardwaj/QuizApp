import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/components/util_functions.dart';
import '../../../topic/topic_screen.dart';

Future<bool> login(context, email, password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .timeout(
          const Duration(
            seconds: 10,
          ),
        );
    if (userCredential.user != null) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, TopicScreen.id, (route) => false);
      }
    }
    return true;
  } on FirebaseAuthException catch (e) {
    logAndShowSnackbar(
      context: context,
      heading: "Login Error",
      text: e.code.toString(),
    );
    return false;
  } catch (e) {
    logAndShowSnackbar(
      context: context,
      heading: "Login Error",
      text: e.toString(),
    );
    return false;
  }
}
