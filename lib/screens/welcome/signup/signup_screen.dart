import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool loading = false;

  void handleRegistration() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim().toLowerCase();
    String password = _passwordController.text.trim();
    String confirmationPassword = _confirmPasswordController.text.trim();
    setState(() {
      loading = true;
    });
    if (await register(context, name, email, password, confirmationPassword)) {
      setState(() {
        _nameController.clear();
        _passwordController.clear();
        _emailController.clear();
        _confirmPasswordController.clear();
      });
    }
    setState(() {
      loading = false;
    });
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
              Image.asset(
                "assets/images/signup.png",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                controller: _nameController,
                iconData: Icons.person,
                hintText: 'Name',
                containerColor: secondaryColor,
                iconColor: primaryColor,
                readOnly: loading,
              ),
              RoundedInputField(
                controller: _emailController,
                iconData: Icons.email_rounded,
                hintText: 'Email',
                containerColor: secondaryColor,
                iconColor: primaryColor,
                readOnly: loading,
              ),
              RoundedPasswordField(
                controller: _passwordController,
                containerColor: secondaryColor,
                iconColor: primaryColor,
                readOnly: loading,
              ),
              RoundedPasswordField(
                controller: _confirmPasswordController,
                containerColor: secondaryColor,
                iconColor: primaryColor,
                hintText: "Confirm Password",
                readOnly: loading,
              ),
              (!loading)
                  ? RoundedButton(
                      text: 'REGISTER',
                      onPressed: () {
                        handleRegistration();
                      },
                      buttonColor: primaryColor,
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: size.width * 0.4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: TextButton(
                          style: const ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.transparent),
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  vertical: 19, horizontal: 40),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(primaryColor),
                          ),
                          onPressed: () {},
                          child: const SpinKitThreeBounce(
                            size: 19,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
