import 'package:flutter/material.dart';
import '../components/already_have_an_account_check.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';
import '../components/rounded_password_field.dart';
import 'components/background.dart';

const Color primaryColor = Color.fromARGB(255, 238, 68, 43);
const Color secondaryColor = Color.fromARGB(255, 254, 222, 218);

class SignUpScreen extends StatelessWidget {
  static const id = "signup_screen";
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "SIGNUP",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  fontSize: 35,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/images/login.jpg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              const RoundedInputField(
                iconData: Icons.person,
                hintText: 'Email',
                containerColor: secondaryColor,
                iconColor: primaryColor,
              ),
              const RoundedPasswordField(
                containerColor: secondaryColor,
                iconColor: primaryColor,
              ),
              RoundedButton(
                text: 'REGISTER',
                onPressed: () {},
                buttonColor: primaryColor,
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                onLoginPage: false,
                onTap: () {
                  Navigator.pop(context);
                },
                color: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
