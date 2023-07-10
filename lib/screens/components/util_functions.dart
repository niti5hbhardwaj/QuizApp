import 'dart:developer';
import 'package:flutter/material.dart';
import 'custom_snack_bar_content.dart';

void logAndShowSnackbar(
    {required BuildContext context,
    String heading = "On Snap!",
    String text = "an error occurred while performing the action",
    Color color = const Color(0xFFC72C41)}) {
  log(text);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: CustomSnackBarContent(
        backgroundColor: color,
        error: heading,
        explanation: text,
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    ),
  );
}
