import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../components/already_have_an_account_check.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';
import '../components/rounded_password_field.dart';
import '../signup/signup_screen.dart';
import 'components/background.dart';
import 'components/util_functions.dart';

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
  bool loading = false;

  void handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    setState(() {
      loading = true;
    });
    if (await login(context, email, password)) {
      setState(() {
        _emailController.clear();
        _passwordController.clear();
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
                "assets/images/login.png",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                controller: _emailController,
                iconData: Icons.mail_rounded,
                hintText: 'Email',
                iconColor: primaryColor,
                containerColor: secondaryColor,
                readOnly: loading,
              ),
              RoundedPasswordField(
                controller: _passwordController,
                containerColor: secondaryColor,
                iconColor: primaryColor,
                readOnly: loading,
              ),
              (!loading)
                  ? RoundedButton(
                      text: 'LOGIN',
                      onPressed: () {
                        handleLogin();
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
                                MaterialStatePropertyAll(Colors.deepPurple),
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
