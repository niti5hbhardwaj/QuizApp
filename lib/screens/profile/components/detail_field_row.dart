import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/custom_snack_bar_content.dart';
import 'inplace_text_editor.dart';

class DetailFieldRow extends StatefulWidget {
  final String fieldName;
  final String fieldData;
  final bool editable;
  const DetailFieldRow({
    super.key,
    required this.fieldName,
    required this.fieldData,
    this.editable = false,
  });

  @override
  State<DetailFieldRow> createState() => _DetailFieldRowState();
}

class _DetailFieldRowState extends State<DetailFieldRow> {
  bool editing = false;
  final TextEditingController _controller = TextEditingController();

  void submitPhoneNumber(String value) async {
    if (value.length != 10) {
      log("Invalid Phone Number");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: CustomSnackBarContent(
            error: 'Invalid Phone Number',
            explanation: "Entered number is not a valid phone number",
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .update({"Phone Number": value}).catchError((e) {
        log("Invalid Phone Number");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: CustomSnackBarContent(
              error: 'Update error',
              explanation: e.toString(),
            ),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      });
      setState(() {
        editing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            widget.fieldName,
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.editable) {
                  setState(() {
                    editing = true;
                    _controller.text = widget.fieldData;
                  });
                }
              },
              child: (!editing)
                  ? Text(
                      widget.fieldData,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 17,
                      ),
                    )
                  : InPlaceTextEditor(
                      controller: _controller,
                      onSubmitted: submitPhoneNumber,
                    ),
            ),
            (widget.editable)
                ? Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade500,
                    size: (!editing) ? 20 : 1,
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
