import 'package:flutter/material.dart';
import 'package:quiz_app/screens/welcome/signup/components/util_functions.dart';
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

  void handleRegistration() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim().toLowerCase();
    String password = _passwordController.text.trim();
    if (await register(context, name, email, password)) {
      setState(() {
        _nameController.clear();
        _passwordController.clear();
        _emailController.clear();
      });
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
                  handleRegistration();
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
