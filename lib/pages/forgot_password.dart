import 'package:aanmai_app/components/login_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.sentiment_satisfied_alt),
                  SizedBox(width: 10.0),
                  Text(
                    'Password reset link sent! Check your email',
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
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.sentiment_dissatisfied_outlined),
                  SizedBox(width: 10.0),
                  Text(
                    e.message.toString(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF9E3CE),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFF68922),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 75, 30, 0),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: SizedBox.fromSize(
                      size: Size(300, 200),
                      child: Image.asset(
                          'assets/images/backgrounds/awkwardSmileCat.jpg',
                          fit: BoxFit.cover))),
              SizedBox(
                height: 10.0,
              ),
              Text(
                  'That\'s no problem! Enter your email and we\'ll send you a password reset link.',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
              SizedBox(
                height: 25.0,
              ),
              MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obsecuredText: false,
                  icon: Icons.person_outlined),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  height: 60,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 236, 153, 75),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      passwordReset();
                    },
                  )),
            ],
          ),
        ));
  }
}
