import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/components/util_functions.dart';
import '../../../topic/topic_screen.dart';

Future<bool> register(BuildContext context, String name, String email,
    String password, String confirmationPassword) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    if (name != "" &&
        email != "" &&
        password != "" &&
        confirmationPassword != "") {
      if (password == confirmationPassword) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .timeout(
              const Duration(
                seconds: 10,
              ),
            );
        if (userCredential.user != null) {
          Map<String, dynamic> userData = {
            "Name": name,
            "Email": email,
            "Score": 0,
            "Phone Number": "000 000000",
            "Date of Birth": "Select",
            "Profile Pic":
                "https://firebasestorage.googleapis.com/v0/b/quizapp-x-flutter.appspot.com/o/defaultProfilePic%2FdefaultProfilePic.png?alt=media&token=c65b9636-04f4-4a19-aa19-67a9629a6ee5",
          };
          try {
            await firestore.collection("users").doc(email).set(userData);
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, TopicScreen.id, (route) => false);
            }
            return true;
          } on FirebaseException catch (e) {
            userCredential.user!.delete();
            if (context.mounted) {
              logAndShowSnackbar(
                context: context,
                text: e.code.toString(),
              );
            }
            return false;
          }
        } else {
          if (context.mounted) {
            logAndShowSnackbar(
              context: context,
            );
          }
          return false;
        }
      } else {
        logAndShowSnackbar(
          context: context,
          heading: 'Registration Error',
          text: "Password and Confirm Password are not same",
        );
        return false;
      }
    } else {
      logAndShowSnackbar(
        context: context,
        heading: 'Registration Error',
        text: "All the field are required",
      );
      return false;
    }
  } on FirebaseAuthException catch (e) {
    logAndShowSnackbar(
      context: context,
      heading: 'Registration Error',
      text: e.code.toString(),
    );
    return false;
  } on TimeoutException {
    logAndShowSnackbar(
      context: context,
      heading: 'Registration Error',
      text: "registration request timed out. try again after some time",
    );
    return false;
  }
}
