import 'package:aanmai_app/template/homepage.dart';
import 'package:aanmai_app/template/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            print('User is logged in');
            return HomePage();
          }
          //user is not logged in
          else
          {
            print('User is not logged in');
            return LogIn();
          }
        })
    );
  }
}