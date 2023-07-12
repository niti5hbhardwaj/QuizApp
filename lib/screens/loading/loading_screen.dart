import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Color backgroundColor = Colors.grey.shade100;
Color foregroundColor = Colors.blueGrey.shade900;

class LoadingScreen extends StatelessWidget {
  static const id = 'loading_screen';
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitSquareCircle(
              color: foregroundColor,
              size: 150,
              duration: const Duration(seconds: 1, milliseconds: 200),
            ),
            SizedBox(
              height: (size.height * 0.25) - 50,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.25),
              child: Text(
                "Preparing Quiz",
                style: TextStyle(
                  fontSize: 25,
                  color: foregroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
