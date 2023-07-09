import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DateFieldRow extends StatefulWidget {
  final String fieldName;
  final String fieldData;
  final bool editable;
  const DateFieldRow({
    super.key,
    required this.fieldName,
    required this.fieldData,
    this.editable = false,
  });

  @override
  State<DateFieldRow> createState() => _DateFieldRowState();
}

class _DateFieldRowState extends State<DateFieldRow> {
  void getNewDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      String date = pickedDate.day.toString();
      String month = pickedDate.month.toString();
      String year = pickedDate.year.toString();
      if (date.length == 1) {
        date = "0$date";
      }
      if (month.length == 1) {
        month = "0$month";
      }
      String formattedDate = "$date.$month.$year";
      //TODO: error handling
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .update({"Date of Birth": formattedDate});
    } else {
      print("No date selected");
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
              onTap: getNewDate,
              child: Text(
                widget.fieldData,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 17,
                ),
              ),
            ),
            (widget.editable)
                ? Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade500,
                    size: 20,
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
