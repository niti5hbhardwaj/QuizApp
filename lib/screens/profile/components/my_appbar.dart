import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Color foregroundColor;
  const MyAppBar({
    super.key,
    required this.title,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: foregroundColor,
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: foregroundColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
