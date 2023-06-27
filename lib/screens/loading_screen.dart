import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Color backgroundColor = Colors.grey.shade900;
Color foregroundColor = Colors.grey.shade200;

class LoadingScreen extends StatefulWidget {
  static const id = 'loading_screen';
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitFoldingCube(
              color: foregroundColor,
              size: 100,
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              "Preparing Quiz",
              style: TextStyle(
                fontSize: 25,
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
