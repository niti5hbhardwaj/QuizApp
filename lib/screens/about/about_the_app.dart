import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/screens/components/util_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTheApp extends StatelessWidget {
  static const id = "about_the_app";
  const AboutTheApp({super.key});

  void openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }

  void openMail(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      if (context.mounted) {
        logAndShowSnackbar(
          context: context,
          heading: "Could not open mail",
          text: "You do not have any mail client installed",
          color: Colors.blueGrey.shade900,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.blueGrey.shade900,
                    size: 35,
                  ),
                ),
                const SizedBox(
                  width: 63,
                ),
                Text(
                  "About the app",
                  style: TextStyle(
                    color: Colors.blueGrey.shade900,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "What is QuizApp?\n",
                      style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "QuizApp is a trivia game app that uses ChatGPT to generate questions. With thousands of questions covering a variety of topics, there's sure to be a quiz for everyone.",
                          style: TextStyle(
                            color: Colors.blueGrey.shade800,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    TextSpan(
                      text: "\n\n\nHow to play?\n",
                      style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "To play QuizApp, simply choose a topic and start answering questions. If you get a question wrong, you can always try again.",
                          style: TextStyle(
                            color: Colors.blueGrey.shade800,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    TextSpan(
                      text: "\n\n\nWhat is so special about QuizApp?\n",
                      style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "After you finish a quiz, you can also ask questions or resolve your doubts using ChatGPT.",
                          style: TextStyle(
                            color: Colors.blueGrey.shade800,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  letterSpacing: 0.2,
                ),
              ),
            ),
            const SizedBox(
              height: 160,
            ),
            Text(
              "Connect with developer:",
              style: TextStyle(
                color: Colors.blueGrey.shade900,
                fontWeight: FontWeight.w600,
                fontSize: 19,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    openUrl("https://www.linkedin.com/in/niti5h/");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: SvgPicture.asset(
                      "assets/svg_icons/linkedIn.svg",
                      height: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () {
                    openUrl("https://github.com/niti5hbhardwaj");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: SvgPicture.asset(
                      "assets/svg_icons/github.svg",
                      height: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () {
                    openMail(context, "mailto:nbhardwaj0404@email.com");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: SvgPicture.asset(
                      "assets/svg_icons/gmail.svg",
                      height: 26,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Made with ♥️ by ",
                      style: TextStyle(color: Colors.blueGrey.shade800),
                    ),
                    TextSpan(
                      text: "Nitish Bhardwaj",
                      style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
