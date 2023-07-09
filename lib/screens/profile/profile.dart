import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_app/screens/profile/components/elevated_container.dart';
import 'package:quiz_app/screens/profile/components/logout_button.dart';
import 'package:quiz_app/screens/welcome/login/login_screen.dart';
import 'components/actionable_icon_button.dart';
import 'components/details_container.dart';
import 'components/my_appbar.dart';

class ProfileScreen extends StatefulWidget {
  static const id = 'profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Default";
  late String score = "null";
  File? profilePic;

  void pickImage() async {
    XFile? pickedXFileImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedXFileImage != null) {
      File imageFile = File(pickedXFileImage.path);
      setState(() {
        profilePic = imageFile;
      });
    } else {
      log("No file selected");
    }
  }

  void deleteAccount() async {
    await FirebaseAuth.instance.currentUser?.delete();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: "profile_pic",
                  child: GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 75,
                      backgroundImage:
                          (profilePic != null) ? FileImage(profilePic!) : null,
                    ),
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
                  height: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Column(
                        children: [
                          Text(
                            "User Details",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          DetailsContainer(),
                        ],
                      ),
                      ElevatedContainer(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            ActionableIconButton(
                              icon: Icons.lock_outline_rounded,
                              text: "Change Password",
                              iconBackgroundColor: Colors.blueGrey.shade900,
                              iconColor: Colors.white,
                              onTap: () {},
                            ),
                            const Divider(
                              height: 20,
                              thickness: 1,
                            ),
                            ActionableIconButton(
                              icon: Icons.delete_forever_outlined,
                              text: "Delete Account",
                              iconBackgroundColor: Colors.blueGrey.shade900,
                              iconColor: Colors.white,
                              onTap: deleteAccount,
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
            ),
          ),
        ],
      ),
    );
  }
}
