import 'package:flutter/material.dart';

class CustomSnackBarContent extends StatelessWidget {
  final Color backgroundColor, textColor;
  final IconData iconData;
  final double height;
  final String error;
  final String explanation;
  const CustomSnackBarContent({
    super.key,
    required this.error,
    required this.explanation,
    this.iconData = Icons.error_outline_rounded,
    this.backgroundColor = const Color(0xFFC72C41),
    this.textColor = Colors.white,
    this.height = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      error,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      explanation,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
