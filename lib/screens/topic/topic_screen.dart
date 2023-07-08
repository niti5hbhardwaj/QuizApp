import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/profile.dart';
import 'package:quiz_app/screens/topic/components/subject_icon_tile.dart';
import '../../chat_api/chat_api.dart';
import '../../data/topics.dart';
import '../error_screen.dart';
import '../loading_screen.dart';
import '../quiz_screen.dart';

class TopicScreen extends StatefulWidget {
  static const id = 'topic_screen';
  const TopicScreen({super.key});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
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
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProfileScreen.id);
                    },
                    child: Hero(
                      tag: "profile_pic",
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ),
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
                  const SizedBox(
                    width: 40,
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
