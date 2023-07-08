import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/elevated_container.dart';
import 'detail_field_row.dart';

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    String? email = FirebaseAuth.instance.currentUser?.email;
    String phoneNumber = "9773868085";

    return ElevatedContainer(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          DetailFieldRow(
            fieldName: "Email",
            fieldData: (email != null) ? email : "Not available",
            editable: false,
          ),
          const Divider(
            height: 30,
            thickness: 1,
          ),
          DetailFieldRow(
            fieldName: "Phone Number",
            fieldData: phoneNumber,
            editable: true,
          ),
          const Divider(
            height: 30,
            thickness: 1,
          ),
          DetailFieldRow(
            fieldName: "Date of Birth",
            fieldData: "04.04.2001",
            editable: true,
          ),
        ],
      ),
    );
  }
}
