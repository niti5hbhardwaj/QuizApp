import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void updateScore(int score) async {
  String? docId = FirebaseAuth.instance.currentUser?.email;
  try {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(docId).get();
    if (documentSnapshot.exists) {
      int previousScore = documentSnapshot.get("Score");
      int newScore = previousScore + (score * 10);
      FirebaseFirestore.instance.collection("users").doc(docId).update({
        "Score": newScore,
      }).catchError((e) {
        log(e.toString());
      });
    }
  } on FirebaseException catch (e) {
    log("Error: ${e.code}");
  }
}
