import 'package:flutter/material.dart';
import '../components/already_have_an_account_check.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';
import '../components/rounded_password_field.dart';
import '../signup/signup_screen.dart';
import 'components/background.dart';

const Color primaryColor = Color.fromARGB(255, 106, 27, 154);
const Color secondaryColor = Color.fromARGB(255, 231, 220, 248);

class LoginScreen extends StatelessWidget {
  static const id = 'login_screen';
  const LoginScreen({super.key});

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
                "LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  fontSize: 35,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/images/signup.jpeg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              const RoundedInputField(
                iconData: Icons.person,
                hintText: 'Email',
                iconColor: primaryColor,
                containerColor: secondaryColor,
              ),
              const RoundedPasswordField(
                containerColor: secondaryColor,
                iconColor: primaryColor,
              ),
              RoundedButton(
                  text: 'LOGIN', onPressed: () {}, buttonColor: primaryColor),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                onLoginPage: true,
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.id);
                },
                color: primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
