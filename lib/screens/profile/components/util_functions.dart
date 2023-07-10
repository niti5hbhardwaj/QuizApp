import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../components/util_functions.dart';
import '../../welcome/login/login_screen.dart';
import 'change_password_dialog.dart';
import 'delete_account_caution_dialog.dart';

Color success = Colors.green.shade500;
Color failure = const Color(0xFFC72C41);

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
      bool successful = true;
      TaskSnapshot taskSnapshot = await uploadTask;
      String profilePicUrl = await taskSnapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection("users").doc(docId).update({
        "Profile Pic": profilePicUrl,
      }).catchError((e) {
        logAndShowSnackbar(
          context: context,
          heading: 'Update Error',
          text: e.toString(),
          color: failure,
        );
        successful = false;
      });
      if (successful) {
        logAndShowSnackbar(
          context: context,
          heading: "Change Successful",
          text: "Your profile picture has been updated successfully",
          color: success,
        );
      }
    } on FirebaseException {
      logAndShowSnackbar(
        context: context,
        heading: 'Upload Error',
        text: "encountered an error while uploading profile picture",
        color: failure,
      );
    }
  } else {
    log("No file selected");
  }
}

Future<bool> deleteAccount(BuildContext context, String password) async {
  if (password != "") {
    AuthCredential credential =
        EmailAuthProvider.credential(email: getEmail(), password: password);
    try {
      UserCredential? userCredential = await FirebaseAuth.instance.currentUser
          ?.reauthenticateWithCredential(credential);
      if (userCredential != null && userCredential.user != null) {
        bool successful = true;
        await FirebaseAuth.instance.currentUser?.delete().catchError((e) {
          successful = false;
          logAndShowSnackbar(
            context: context,
            heading: "Could not delete account",
            text: e.toString(),
          );
        });
        if (successful) {
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.id, (route) => false);
          }
          return true;
        }
        return false;
      } else {
        if (context.mounted) {
          logAndShowSnackbar(
            context: context,
            heading: 'Could not delete account',
            text: "Wrong password entered",
            color: failure,
          );
        }
        return false;
      }
    } on FirebaseAuthException catch (e) {
      logAndShowSnackbar(
        context: context,
        heading: 'Could not delete account',
        text: e.code.toString(),
        color: failure,
      );
      return false;
    }
  } else {
    logAndShowSnackbar(
      context: context,
      heading: 'Could not delete account',
      text: "Password field cannot be left empty",
      color: failure,
    );
    return false;
  }
}

Future openCautionDialog(context) {
  return showDialog(
      context: context,
      builder: (context) => const DeleteAccountCautionDialog());
}

String getEmail() {
  String? email = FirebaseAuth.instance.currentUser?.email;
  return (email == null) ? "N.A." : email;
}

Future openChangePasswordDialog(context) {
  return showDialog(
      context: context, builder: (context) => const ChangePasswordDialog());
}

Future<bool> changePassword(
    BuildContext context, List<String>? passwords) async {
  if (passwords != null) {
    AuthCredential credential =
        EmailAuthProvider.credential(email: getEmail(), password: passwords[0]);
    try {
      UserCredential? userCredential = await FirebaseAuth.instance.currentUser
          ?.reauthenticateWithCredential(credential);
      if (userCredential != null && userCredential.user != null) {
        if ((passwords[0] != passwords[1])) {
          bool successful = true;
          await userCredential.user
              ?.updatePassword(passwords[1])
              .catchError((e) {
            logAndShowSnackbar(
              context: context,
              heading: "Password change unsuccessful",
              text: e.toString(),
              color: failure,
            );
            successful = false;
          });
          if (successful) {
            if (context.mounted) {
              logAndShowSnackbar(
                context: context,
                heading: 'Password Change Successful',
                text: "Your password has been changed successfully.",
                color: success,
              );
              return true;
            }
            return true;
          }
        } else {
          if (context.mounted) {
            logAndShowSnackbar(
              context: context,
              heading: 'Password change unsuccessful',
              text: "new password cannot be the same as old password",
              color: failure,
            );
          }
          return false;
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      logAndShowSnackbar(
        context: context,
        heading: 'Password change unsuccessful',
        text: e.code.toString(),
        color: failure,
      );
    }
  }
  return false;
}

Future<bool> changePhoneNumber(BuildContext context, String value) async {
  if (value.length != 10) {
    logAndShowSnackbar(
      context: context,
      heading: 'Invalid Phone Number',
      text: "Entered number is not a valid phone number",
      color: failure,
    );
    return false;
  } else {
    bool successful = true;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .update({"Phone Number": value}).catchError((e) {
      logAndShowSnackbar(
        context: context,
        heading: 'Update error',
        text: e.toString(),
        color: failure,
      );
      successful = false;
    });
    if (successful) {
      if (context.mounted) {
        logAndShowSnackbar(
          context: context,
          heading: "Change Successful",
          text: "Your phone number has been updated successfully",
          color: success,
        );
      }
      return true;
    }
    return false;
  }
}

Future<void> getNewDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (pickedDate != null) {
    String date = pickedDate.day.toString();
    String month = pickedDate.month.toString();
    String year = pickedDate.year.toString();
    if (date.length == 1) {
      date = "0$date";
    }
    if (month.length == 1) {
      month = "0$month";
    }
    String formattedDate = "$date.$month.$year";
    bool successful = true;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .update({"Date of Birth": formattedDate}).catchError((e) {
      logAndShowSnackbar(
        context: context,
        heading: 'Update error',
        text: "error while updating date of birth",
        color: failure,
      );
      successful = false;
    });
    if (successful) {
      if (context.mounted) {
        logAndShowSnackbar(
          context: context,
          heading: "Change Successful",
          text: "Your date of birth has been updated successfully",
          color: success,
        );
      }
    }
  } else {
    log("No date selected");
  }
}

void logout(context) async {
  bool successful = true;
  await FirebaseAuth.instance.signOut().catchError((e) {
    successful = false;
    logAndShowSnackbar(
        context: context, heading: "Logout Error", text: e.toString());
  });
  if (successful && context.mounted) {
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (route) => false);
  }
}
