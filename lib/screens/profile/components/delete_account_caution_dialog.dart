import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz_app/screens/profile/components/util_functions.dart';
import 'package:quiz_app/screens/welcome/login/login_screen.dart';

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
  bool inProgress = false;
  @override
  Widget build(BuildContext context) {
    return (!inProgress)
        ? AlertDialog(
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
                    "Deleting account results in loss of progress. This action can't be undone.\n\nDo you want to proceed? ",
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
                color: firstWarning
                    ? Colors.blueGrey.shade900
                    : const Color(0xFFC72C41),
                elevation: 0,
                height: 40,
                minWidth: 110,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () async {
                  if (firstWarning) {
                    setState(() {
                      firstWarning = false;
                    });
                  } else {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    setState(() {
                      inProgress = true;
                    });
                    bool successful = await deleteAccount(
                        context, passwordController.text.trim());
                    setState(() {
                      inProgress = false;
                    });
                    if (successful) {
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.id, (route) => false);
                      }
                    }
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
          )
        : const Center(
            child: SpinKitSquareCircle(color: Colors.white),
          );
  }
}
