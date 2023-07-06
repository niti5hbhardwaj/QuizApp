import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool onLoginPage;
  final VoidCallback onTap;
  final Color color;
  const AlreadyHaveAnAccountCheck({
    super.key,
    required this.onTap,
    this.onLoginPage = true,
    this.color = Colors.black,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          (onLoginPage)
              ? "Don't have an account? "
              : "Already have an account? ",
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            (onLoginPage) ? "Sign Up" : "Sign In",
            style: TextStyle(color: color),
          ),
        ),
      ],
    );
  }
}
