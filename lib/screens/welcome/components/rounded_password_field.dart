import 'package:flutter/material.dart';
import 'package:quiz_app/screens/welcome/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final Color iconColor, containerColor;
  final ValueChanged<String>? onChanged;
  const RoundedPasswordField({
    super.key,
    this.onChanged,
    this.iconColor = Colors.grey,
    this.containerColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: containerColor,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: iconColor,
          ),
          hintText: "Password",
          border: InputBorder.none,
          suffixIcon: Icon(
            Icons.visibility,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
