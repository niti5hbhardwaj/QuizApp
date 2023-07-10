import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/elevated_container.dart';
import 'package:quiz_app/screens/profile/components/util_functions.dart';
import 'date_field_row.dart';
import 'detail_field_row.dart';

class DetailsContainer extends StatelessWidget {
  final String phoneNumber;
  final String date;
  const DetailsContainer(
      {super.key, required this.phoneNumber, required this.date});

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          DetailFieldRow(
            fieldName: "Email",
            fieldData: getEmail(),
            editable: false,
          ),
          const Divider(
            height: 20,
            thickness: 1,
          ),
          DetailFieldRow(
            fieldName: "Phone Number",
            fieldData: phoneNumber,
            editable: true,
          ),
          const Divider(
            height: 20,
            thickness: 1,
          ),
          DateFieldRow(
            fieldName: "Date of Birth",
            fieldData: date,
            editable: true,
          ),
        ],
      ),
    );
  }
}
