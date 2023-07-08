import 'package:flutter/material.dart';

class DetailFieldRow extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          fieldName,
          style: TextStyle(
            color: Colors.blueGrey.shade900,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            Text(
              fieldData,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 17,
              ),
            ),
            (editable)
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
