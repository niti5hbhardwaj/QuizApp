import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../profile/profile.dart';
import 'empty_circle_avatar.dart';

class TopicScreenProfilePic extends StatelessWidget {
  const TopicScreenProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data!.exists) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.id);
              },
              child: Hero(
                tag: "profilePic",
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: (snapshot.data != null)
                      ? NetworkImage(snapshot.data?.get("Profile Pic"))
                      : null,
                ),
              ),
            );
          } else {
            return const EmptyCircleAvatar();
          }
        } else {
          return const EmptyCircleAvatar();
        }
      },
    );
  }
}
