import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor, textColor;
  const RoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = Colors.deepPurple,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 19, horizontal: 40),
            ),
            backgroundColor: MaterialStatePropertyAll(buttonColor),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
