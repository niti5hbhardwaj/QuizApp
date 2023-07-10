import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/util_functions.dart';

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
                getNewDate(context);
              },
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
