import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/util_functions.dart';

class DeleteAccountConfirmationDialog extends StatelessWidget {
  const DeleteAccountConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: Colors.grey.shade100,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Delete Account",
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      contentPadding:
          const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
      content: Text(
        "Deleting account results in lose of progress. This action can't be undone.\n\nAre you sure?",
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 16,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: EdgeInsets.all(15),
      actions: [
        MaterialButton(
          color: Colors.white,
          elevation: 0,
          height: 40,
          minWidth: 110,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.blueGrey.shade900,
            ),
          ),
        ),
        MaterialButton(
          color: Colors.blueGrey.shade900,
          elevation: 0,
          height: 40,
          minWidth: 110,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            //TODO: loading screen to indicate something is happening
            deleteAccount(context);
          },
          child: Text(
            "Delete",
            style: TextStyle(
              color: Colors.grey.shade100,
            ),
          ),
        ),
      ],
    );
  }
}
