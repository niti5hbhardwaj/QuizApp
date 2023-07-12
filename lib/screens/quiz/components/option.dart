import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String optionText;
  final int index;
  final VoidCallback onPressed;
  final Color color;
  final IconData? icon;

  const Option({
    super.key,
    required this.optionText,
    required this.index,
    required this.onPressed,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: (color == Colors.grey)
              ? Colors.transparent
              : color.withOpacity(0.1),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${index + 1}. $optionText",
                style: TextStyle(
                  color: (color == Colors.grey) ? Colors.grey.shade800 : color,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: color),
                color: (icon != null) ? color : Colors.transparent,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
