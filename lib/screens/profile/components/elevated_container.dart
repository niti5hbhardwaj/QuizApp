import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {
  final Color color;
  final EdgeInsets? padding;
  final Widget child;
  const ElevatedContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(0),
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset.fromDirection(1, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
