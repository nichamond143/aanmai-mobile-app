import 'package:aanmai_app/auth/auth_service.dart';
import 'package:aanmai_app/components/login_textfield.dart';
import 'package:aanmai_app/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  final Function()? onTap;
  const LogIn({super.key, required this.onTap});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //Log in users
  void logInUsers() async {

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

    } on FirebaseAuthException catch (e) {

      //Show error message
      showErrorMessage(e.code);
    }
  }

  //Invalid Email or Password Notification
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.sentiment_dissatisfied_outlined),
                SizedBox(width: 10.0),
                Text(
                  message,
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorSchemeSeed: const Color(0xFFF68922), useMaterial3: true),
        home: Scaffold(
            backgroundColor: Color(0xFFF9E3CE),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Color(0xFF46474B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50),
                            )),

                        //Input Email
                        MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obsecuredText: false,
                          icon: Icons.person_outlined,
                        ),

                        //Input Password
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obsecuredText: true,
                          icon: Icons.lock_outlined,
                        ),

                        //Forgot Password
                        TextButton(
                          onPressed: () {
                            //forgot password screen
                            Navigator.pushNamed(context, '/resetPassword');
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xFFF68922),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        //Login button
                        Container(
                            height: 60,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 236, 153, 75),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                              ),
                              onPressed: () {
                                //Log in Users
                                logInUsers();
                              },
                            )),

                        SizedBox(height: 50.0),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: Colors.grey,
                              )),
                              Text('or continue with'),
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: Colors.grey,
                              )),
                            ],
                          ),
                        ),

                        const SizedBox(height: 50.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SquareTile(
                                onTap: () => AuthService().signInWithGoogle(),
                                imagePath:
                                    'assets/images/logos/google-logo.png',
                                label: 'Google'),
                            SizedBox(
                              width: 25.0,
                            ),
                            SquareTile(
                                onTap: () => AuthService().signInWithFacebook(),
                                imagePath:
                                    'assets/images/logos/facebook-logo.png',
                                label: 'Facebook')
                          ],
                        ),

                        SizedBox(height: 10.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Don\'t have an account?'),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: widget.onTap,
                                child: Text(
                                  'Sign Up Now',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xFFF68922)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            )));
  }
}
