import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../topic/topic_screen.dart';
import '../components/already_have_an_account_check.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';
import '../components/rounded_password_field.dart';
import 'components/background.dart';

const Color primaryColor = Color.fromARGB(255, 238, 68, 43);
const Color secondaryColor = Color.fromARGB(255, 254, 222, 218);

class SignUpScreen extends StatefulWidget {
  static const id = "signup_screen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void register() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        if (context.mounted) {
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
              RoundedInputField(
                controller: _emailController,
                iconData: Icons.person,
                hintText: 'Email',
                containerColor: secondaryColor,
                iconColor: primaryColor,
              ),
              RoundedPasswordField(
                controller: _passwordController,
                containerColor: secondaryColor,
                iconColor: primaryColor,
              ),
              RoundedButton(
                text: 'REGISTER',
                onPressed: () {
                  register();
                },
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
