import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/util_functions.dart';

class DeleteAccountCautionDialog extends StatefulWidget {
  const DeleteAccountCautionDialog({super.key});

  @override
  State<DeleteAccountCautionDialog> createState() =>
      _DeleteAccountCautionDialogState();
}

class _DeleteAccountCautionDialogState
    extends State<DeleteAccountCautionDialog> {
  bool firstWarning = true;
  TextEditingController passwordController = TextEditingController();
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
      content: (firstWarning)
          ? Text(
              "Deleting account results in lose of progress. This action can't be undone.\n\nDo you want to proceed? ",
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Enter your password to delete the account",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    autofocus: true,
                    onChanged: (value) {},
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: "Current Password",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: const EdgeInsets.all(15),
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
          color:
              firstWarning ? Colors.blueGrey.shade900 : const Color(0xFFC72C41),
          elevation: 0,
          height: 40,
          minWidth: 110,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            //TODO: loading screen to indicate something is happening
            if (firstWarning) {
              setState(() {
                firstWarning = false;
              });
            } else {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              deleteAccount(context, passwordController.text.trim());
            }
          },
          child: Text(
            firstWarning ? "Proceed" : "Delete",
            style: TextStyle(
              color: Colors.grey.shade100,
            ),
          ),
        ),
      ],
    );
  }
}
