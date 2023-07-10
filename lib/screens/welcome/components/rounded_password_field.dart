import 'package:flutter/material.dart';
import 'package:quiz_app/screens/welcome/components/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final Color iconColor, containerColor;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool readOnly;
  final String hintText;
  const RoundedPasswordField({
    super.key,
    this.onChanged,
    this.iconColor = Colors.grey,
    this.containerColor = Colors.white,
    this.controller,
    this.readOnly = false,
    this.hintText = "Password",
  });

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool hidden = true;
  void showPasswordForSometime() async {
    showPassword();
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {});
    hidePassword();
  }

  void showPassword() {
    setState(() {
      hidden = false;
    });
  }

  void hidePassword() {
    setState(() {
      hidden = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: widget.containerColor,
      child: TextField(
        readOnly: widget.readOnly,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: hidden,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: widget.iconColor,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: showPasswordForSometime,
            onLongPress: showPassword,
            onLongPressUp: hidePassword,
            child: Icon(
              Icons.visibility,
              color: widget.iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
