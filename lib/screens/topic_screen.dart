import 'package:flutter/material.dart';
import 'package:quiz_app/chat_api/chat_api.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import '../data/topics.dart';
import 'loading_screen.dart';

class TopicScreen extends StatelessWidget {
  static const id = 'topic_screen';
  const TopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GridView.builder(
          itemCount: topicList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, LoadingScreen.id);
                await getQuestions(topicList[index].topicName);
                Navigator.of(context).pop();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, QuizScreen.id);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
