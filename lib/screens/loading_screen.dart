import 'package:flutter/material.dart';
import 'package:quiz_app/chat_api/chat_api.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const id = 'loading_screen';
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    loadData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
    );
  }
}

Future loadData(context) async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
}
