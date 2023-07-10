import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz_app/screens/profile/components/util_functions.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  bool inProgress = false;
  final TextEditingController _newPasswordController = TextEditingController();

  void handleChange(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {
      inProgress = true;
    });
    bool success = await changePassword(context, [
      _currentPasswordController.text.trim(),
      _newPasswordController.text.trim()
    ]);
    setState(() {
      inProgress = false;
    });
    if (success) {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (!inProgress)
        ? AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            backgroundColor: Colors.grey.shade200,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Change Password",
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
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _currentPasswordController,
                    obscureText: true,
                    onChanged: (value) {},
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: "Current Password",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                  width: 500,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    onChanged: (value) {},
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: "New Password",
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
                color: Colors.blueGrey.shade900,
                elevation: 0,
                height: 40,
                minWidth: 110,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {
                  handleChange(context);
                },
                child: Text(
                  "Submit",
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
