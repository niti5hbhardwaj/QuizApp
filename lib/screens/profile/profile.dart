import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/elevated_container.dart';
import 'package:quiz_app/screens/profile/components/logout_button.dart';
import 'components/actionable_icon_button.dart';
import 'components/my_appbar.dart';
import 'components/user_details.dart';
import 'components/util_functions.dart';

class ProfileScreen extends StatefulWidget {
  static const id = 'profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          MyAppBar(
            title: "Profile Details",
            foregroundColor: Colors.blueGrey.shade900,
          ),
          const UserDetails(),
          Expanded(
            flex: 30,
            child: Column(
              children: [
                ElevatedContainer(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      ActionableIconButton(
                        icon: Icons.lock_outline_rounded,
                        text: "Change Password",
                        iconBackgroundColor: Colors.blueGrey.shade900,
                        iconColor: Colors.white,
                        onTap: () {
                          openChangePasswordDialog(context);
                        },
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      ActionableIconButton(
                        icon: Icons.delete_forever_outlined,
                        text: "Delete Account",
                        iconBackgroundColor: Colors.blueGrey.shade900,
                        iconColor: Colors.white,
                        onTap: () {
                          openCautionDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
                //TODO: create a page
                ElevatedContainer(
                  padding: const EdgeInsets.all(15),
                  child: ActionableIconButton(
                    icon: Icons.info_outline,
                    text: "About the app",
                    iconBackgroundColor: Colors.blueGrey.shade900,
                    iconColor: Colors.white,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          const LogoutButton(),
        ],
      ),
    );
  }
}
