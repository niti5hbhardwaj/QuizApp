import 'package:flutter/material.dart';
import 'package:quiz_app/chat_api/chat_api.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import '../data/topics.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

class TopicScreen extends StatelessWidget {
  static const id = 'topic_screen';
  const TopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GridView.builder(
          itemCount: topicList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                bool success;
                Navigator.pushNamed(context, LoadingScreen.id);
                success = await getQuestions(topicList[index].topicName);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
                if (success && context.mounted) {
                  Navigator.pushReplacementNamed(context, QuizScreen.id);
                } else {
                  Navigator.pushReplacementNamed(context, BrokenLinkScreen.id);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/topic_files/${topicList[index].topicImage}"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
//
// Future<bool> getQuestions(String topic) async {
//   await Future.delayed(const Duration(seconds: 1, milliseconds: 800), () {
//     log("Hello");
//     return true;
//   });
//   return true;
// }
