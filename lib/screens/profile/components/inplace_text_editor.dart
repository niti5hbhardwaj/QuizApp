import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InPlaceTextEditor extends StatelessWidget {
  final TextEditingController controller;
  final Function onSubmitted;
  const InPlaceTextEditor(
      {super.key, required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      height: 20,
      child: TextField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        keyboardType: TextInputType.number,
        controller: controller,
        autofocus: true,
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 17,
        ),
        decoration: const InputDecoration(
          isCollapsed: true,
        ),
        onSubmitted: (value) {
          onSubmitted(value);
        },
      ),
    );
  }
}
