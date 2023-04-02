import 'package:aanmai_app/pages/login.dart';
import 'package:aanmai_app/pages/signup.dart';
import 'package:flutter/material.dart';

class LogInOrSignUpPage extends StatefulWidget {
  const LogInOrSignUpPage({super.key});

  @override
  State<LogInOrSignUpPage> createState() => _LogInOrSignUpPageState();
}

class _LogInOrSignUpPageState extends State<LogInOrSignUpPage> {
  
  //initially show login page
  bool showLogInPage = true;

  //toggle between login and signin page
  void togglePages() {
    setState(() {
      showLogInPage = !showLogInPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLogInPage) {
      return LogIn(onTap: togglePages,);
    }
    else {
      return SignUp(onTap: togglePages,);
    }
  }
}