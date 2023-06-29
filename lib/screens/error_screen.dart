import 'package:flutter/material.dart';
import 'package:quiz_app/screens/topic_screen.dart';

class BrokenLinkScreen extends StatelessWidget {
  static const id = "broken_link_screen";
  const BrokenLinkScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/11_Broken Link.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: MaterialButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, TopicScreen.id);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              height: 50,
              minWidth: 150,
              child: const Text(
                "RETRY",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
