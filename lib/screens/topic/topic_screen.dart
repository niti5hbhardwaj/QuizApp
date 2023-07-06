import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/topic/subject_icon_tile.dart';
import '../../data/topics.dart';
import '../error_screen.dart';
import '../loading_screen.dart';
import '../quiz_screen.dart';

class TopicScreen extends StatelessWidget {
  static const id = 'topic_screen';
  const TopicScreen({super.key});

  void startQuiz(context, index) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, left: 20, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "Select a topic",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: topicList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return SubjectIconTile(
                    onTap: () {
                      startQuiz(context, index);
                    },
                    iconPath: topicList[index].topicImage,
                    subjectName: topicList[index].topicName,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> getQuestions(String topic) async {
  await Future.delayed(const Duration(seconds: 1, milliseconds: 800), () {
    log("Hello");
    return true;
  });
  return true;
}
