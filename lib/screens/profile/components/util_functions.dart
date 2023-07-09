import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/delete_account_confirmation_dialog.dart';
import '../../welcome/login/login_screen.dart';
import 'change_password_dialog.dart';

void updateImage() async {
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
      });
    } on FirebaseException catch (e) {
      // TODO
      log(e.code.toString());
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
  } on Exception catch (e) {
    // TODO
    print("Error occurred while deleting the account");
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
        userCredential.user?.updatePassword(passwords[1]).catchError((error) {
          log("First Error: ${error.toString()}");
        });
      }
    } on FirebaseAuthException catch (error) {
      log("Second Error: ${error.code}");
    }
  }
}
