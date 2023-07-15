import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/util_functions.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: MaterialButton(
        onPressed: () {
          logout(context);
        },
        color: Colors.blueGrey.shade900,
        height: 60,
        minWidth: 250,
        elevation: 4,
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
