import 'package:flutter/material.dart';
import 'package:quiz_app/screens/topic/topic_screen.dart';

class NetworkErrorScreen extends StatelessWidget {
  static const id = "network_error_screen";
  const NetworkErrorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/detective.png",
            fit: BoxFit.fitWidth,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  "404",
                  style: TextStyle(
                    fontSize: 95,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: Color(0xFF686E83),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Looks like this page is missing. Don't worry though our best man is on the case",
                    style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 1,
                      color: Color(0xFF686E83),
                    ),
                    textAlign: TextAlign.center,
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
              color: const Color(0xFF686E83),
              height: 60,
              minWidth: 200,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "GO HOME",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade100,
                    letterSpacing: 1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
