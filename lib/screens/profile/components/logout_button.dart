import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../welcome/login/login_screen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() async {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: MaterialButton(
        onPressed: logout,
        color: Colors.blueGrey.shade900,
        height: 60,
        minWidth: 250,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "Log Out",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
