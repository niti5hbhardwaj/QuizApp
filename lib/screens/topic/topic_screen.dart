import 'package:flutter/material.dart';
import 'package:quiz_app/screens/error/network_error_screen.dart';
import 'package:quiz_app/screens/topic/components/subject_icon_tile.dart';
import '../../chat_api/chat_gpt.dart';
import '../../data/topics.dart';
import '../error/lost_in_space.dart';
import '../loading/loading_screen.dart';
import '../quiz/quiz_screen.dart';
import 'components/topic_screen_profile_pic.dart';

class TopicScreen extends StatefulWidget {
  static const id = 'topic_screen';
  const TopicScreen({super.key});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  void startQuiz(context, index) async {
    String errorType;
    ChatGPT chatGPT = ChatGPT();
    Navigator.pushNamed(context, LoadingScreen.id);
    errorType = await chatGPT.getQuestions(topicList[index].topicName);
    if (errorType == "none" && context.mounted) {
      Navigator.pushReplacementNamed(context, QuizScreen.id);
    } else {
      if (errorType == "timeout") {
        Navigator.pushReplacementNamed(context, NetworkErrorScreen.id);
      } else if (errorType == "unknown") {
        Navigator.pushReplacementNamed(context, LostInSpace.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            collapsedHeight: 75,
            backgroundColor: Colors.grey.shade100,
            expandedHeight: 85,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(
                  top: 25, bottom: 16, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TopicScreenProfilePic(),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "QuizApp",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey.shade800,
                        letterSpacing: 1,
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
          SliverToBoxAdapter(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: topicList.length,
              shrinkWrap: true,
              primary: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20, crossAxisSpacing: 20, crossAxisCount: 2),
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
          )
        ],
      ),
    );
  }
}

// Future<String> getQuestions(String topic) async {
//   await Future.delayed(const Duration(seconds: 1, milliseconds: 800), () {
//     return "none";
//   });
//   return "none";
// }
