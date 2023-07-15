import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/util_functions.dart';
import 'details_container.dart';
import 'empty_data_container.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
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
            String name = snapshot.data?.get("Name");
            String score = snapshot.data!.get("Score").toString();
            String phoneNumber = snapshot.data!.get("Phone Number");
            String date = snapshot.data!.get("Date of Birth");
            String profilePic = snapshot.data!.get("Profile Pic");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: "profilePic",
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 75,
                          backgroundImage: NetworkImage(profilePic),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          updateImage(context);
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 20,
                            color: Colors.blueGrey.shade900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.blueGrey.shade800,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Score:",
                      style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      score,
                      style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    DetailsContainer(
                      phoneNumber: phoneNumber,
                      date: date,
                    ),
                  ],
                ),
              ],
            );
          }
          return const EmptyDataContainer();
        } else {
          return const EmptyDataContainer();
        }
      },
    );
  }
}
