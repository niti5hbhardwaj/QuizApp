import 'package:flutter/material.dart';
import 'package:quiz_app/screens/welcome/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final Color iconColor, containerColor;
  final ValueChanged<String>? onChanged;
  const RoundedInputField({
    super.key,
    required this.hintText,
    this.iconData = Icons.data_object,
    this.onChanged,
    this.iconColor = Colors.grey,
    this.containerColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: containerColor,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
