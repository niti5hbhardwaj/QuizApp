import 'package:flutter/material.dart';
import 'package:quiz_app/screens/topic/topic_screen.dart';

class LostInSpace extends StatelessWidget {
  static const id = "broken_link_screen";
  const LostInSpace({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/broken_link.png",
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width * 0.9,
          ),
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  "OOPS!",
                  style: TextStyle(
                    fontSize: 95,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  "LOST IN SPACE",
                  style: TextStyle(
                    fontSize: 37,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: MaterialButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, TopicScreen.id, (route) => false);
              },
              color: const Color(0xFF141E3F),
              height: 60,
              minWidth: 200,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "GO HOME",
                style: TextStyle(
                    fontSize: 20, color: Colors.white, letterSpacing: 1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
