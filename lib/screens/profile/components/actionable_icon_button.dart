import 'package:flutter/material.dart';

class ActionableIconButton extends StatelessWidget {
  final Color iconColor;
  final Color iconBackgroundColor;
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const ActionableIconButton({
    super.key,
    required this.icon,
    required this.text,
    this.iconBackgroundColor = Colors.black,
    this.iconColor = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey.shade900,
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
