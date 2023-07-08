import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/topic/topic_screen.dart';
import '../components/already_have_an_account_check.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';
import '../components/rounded_password_field.dart';
import '../signup/signup_screen.dart';
import 'components/background.dart';

const Color primaryColor = Color.fromARGB(255, 106, 27, 154);
const Color secondaryColor = Color.fromARGB(255, 231, 220, 248);

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        if (context.mounted) {
          Navigator.popUntil(context, (route) => false);
          Navigator.pushNamed(context, TopicScreen.id);
        }
        setState(() {
          _emailController.clear();
          _passwordController.clear();
        });
      }
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
    }
  }

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
              RoundedInputField(
                controller: _emailController,
                iconData: Icons.person,
                hintText: 'Email',
                iconColor: primaryColor,
                containerColor: secondaryColor,
              ),
              RoundedPasswordField(
                controller: _passwordController,
                containerColor: secondaryColor,
                iconColor: primaryColor,
              ),
              RoundedButton(
                  text: 'LOGIN',
                  onPressed: () {
                    login();
                  },
                  buttonColor: primaryColor),
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
