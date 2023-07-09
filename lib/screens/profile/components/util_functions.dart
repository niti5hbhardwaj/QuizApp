import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/delete_account_confirmation_dialog.dart';
import '../../components/custom_snack_bar_content.dart';
import '../../welcome/login/login_screen.dart';
import 'change_password_dialog.dart';

void updateImage(context) async {
  String? docId = FirebaseAuth.instance.currentUser?.email;
  XFile? pickedXFileImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedXFileImage != null) {
    File imageFile = File(pickedXFileImage.path);
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("profilePics")
        .child(docId!)
        .putFile(imageFile);
    try {
      TaskSnapshot taskSnapshot = await uploadTask;
      String profilePicUrl = await taskSnapshot.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("users").doc(docId).update({
        "Profile Pic": profilePicUrl,
      }).catchError((e) {
        log(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: CustomSnackBarContent(
              error: 'Update Error',
              explanation: e.toString(),
            ),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      });
    } on FirebaseException catch (e) {
      log(e.code.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: CustomSnackBarContent(
            error: 'Upload Error',
            explanation: "encountered an error while uploading profile picture",
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  } else {
    log("No file selected");
  }
}

void deleteAccount(context) async {
  try {
    await FirebaseAuth.instance.currentUser?.delete();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (route) => false);
  } on FirebaseAuthException catch (e) {
    log(e.code.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: CustomSnackBarContent(
          error: 'Could not delete account',
          explanation: e.code.toString(),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

Future openDialog(context) {
  return showDialog(
      context: context,
      builder: (context) => const DeleteAccountConfirmationDialog());
}

String getEmail() {
  String? email = FirebaseAuth.instance.currentUser!.email;
  return (email == null) ? "" : email;
}

Future changePassword(context) async {
  List<String>? passwords = await showDialog(
      context: context, builder: (context) => ChangePasswordDialog());
  if (passwords != null) {
    AuthCredential credential =
        EmailAuthProvider.credential(email: getEmail(), password: passwords[0]);
    try {
      UserCredential? userCredential = await FirebaseAuth.instance.currentUser
          ?.reauthenticateWithCredential(credential);
      if (userCredential != null && userCredential.user != null) {
        userCredential.user?.updatePassword(passwords[1]).catchError((e) {
          log("First Error: ${e.toString()}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: CustomSnackBarContent(
                error: 'Could not change password',
                explanation: e.code.toString(),
              ),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      log("Second Error: ${e.code}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: CustomSnackBarContent(
            error: 'Could not change password',
            explanation: e.code.toString(),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
