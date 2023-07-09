import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/custom_snack_bar_content.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void register() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim().toLowerCase();
    String password = _passwordController.text.trim();

    try {
      if (name != "" && email != "" && password != "") {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Map<String, dynamic> userData = {
            "Name": name,
            "Email": email,
            "Score": 0,
            "Phone Number": "000 000000",
            "Date of Birth": "Select",
            "Profile Pic":
                "https://firebasestorage.googleapis.com/v0/b/quizapp-x-flutter.appspot.com/o/defaultProfilePic%2FdefaultProfilePic.png?alt=media&token=c65b9636-04f4-4a19-aa19-67a9629a6ee5",
          };
          try {
            await _firestore.collection("users").doc(email).set(userData);
            if (context.mounted) {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(context, TopicScreen.id);
            }
            setState(() {
              _emailController.clear();
              _passwordController.clear();
              _nameController.clear();
            });
          } on FirebaseException catch (e) {
            userCredential.user!.delete();
            log("Second Error: ${e.code}");
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: CustomSnackBarContent(
              error: 'Registration Error',
              explanation: "All the field are required",
            ),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      log("First Error: ${e.code}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: CustomSnackBarContent(
            error: 'Registration Error',
            explanation: e.code.toString(),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
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
                controller: _nameController,
                iconData: Icons.person,
                hintText: 'Name',
                containerColor: secondaryColor,
                iconColor: primaryColor,
              ),
              RoundedInputField(
                controller: _emailController,
                iconData: Icons.email_rounded,
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
