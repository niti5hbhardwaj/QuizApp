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
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: foregroundColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
