import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/elevated_container.dart';
import 'package:quiz_app/screens/profile/components/logout_button.dart';
import 'components/actionable_icon_button.dart';
import 'components/details_container.dart';
import 'components/my_appbar.dart';
import 'components/util_functions.dart';

class ProfileScreen extends StatefulWidget {
  static const id = 'profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? docId = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          MyAppBar(
            title: "Profile Details",
            foregroundColor: Colors.blueGrey.shade900,
          ),
          Expanded(
            flex: 7,
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(docId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    String name = snapshot.data?.get("Name");
                    String score = snapshot.data!.get("Score").toString();
                    String phoneNumber = snapshot.data!.get("Phone Number");
                    String date = snapshot.data!.get("Date of Birth");
                    String profilePic = snapshot.data!.get("Profile Pic");
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: "profilePic",
                          child: GestureDetector(
                            onTap: updateImage,
                            child: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                radius: 75,
                                backgroundImage: NetworkImage(profilePic)),
                          ),
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
                          height: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  DetailsContainer(
                                    phoneNumber: phoneNumber,
                                    date: date,
                                  ),
                                ],
                              ),
                              ElevatedContainer(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    ActionableIconButton(
                                      icon: Icons.lock_outline_rounded,
                                      text: "Change Password",
                                      iconBackgroundColor:
                                          Colors.blueGrey.shade900,
                                      iconColor: Colors.white,
                                      onTap: () {
                                        changePassword(context);
                                      },
                                    ),
                                    const Divider(
                                      height: 20,
                                      thickness: 1,
                                    ),
                                    ActionableIconButton(
                                      icon: Icons.delete_forever_outlined,
                                      text: "Delete Account",
                                      iconBackgroundColor:
                                          Colors.blueGrey.shade900,
                                      iconColor: Colors.white,
                                      onTap: () {
                                        openDialog(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedContainer(
                                padding: const EdgeInsets.all(15),
                                child: ActionableIconButton(
                                  icon: Icons.info_outline,
                                  text: "About the app",
                                  iconBackgroundColor: Colors.blueGrey.shade900,
                                  iconColor: Colors.white,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        const LogoutButton(),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
