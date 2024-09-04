import 'package:aanmai_app/auth/auth_service.dart';
import 'package:aanmai_app/components/login_textfield.dart';
import 'package:aanmai_app/components/square_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function()? onTap;
  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  //Sign up users
  void signUpUsers() async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      if (passwordController.text == confirmPassController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        final User? currentUser = FirebaseAuth.instance.currentUser;
        await saveUser(
            firstNameController.text.trim(),
            lastNameController.text.trim(),
            emailController.text.trim(),
            currentUser);

          // ignore: use_build_context_synchronously
          Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        showErrorMessage("Oops! Passwords don't match!");
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      //Show error message
      showErrorMessage(e.code);
    }
  }

  Future<void> saveUser(String firstName, String lastName, String email,
      User? currentUser) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .set({
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "photoUrl":
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
      "uid": currentUser.uid,
    });
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
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 20.0),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
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
                              'Sign Up',
                              style: TextStyle(
                                  color: Color(0xFF46474B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50),
                            )),

                        //Input Name
                        MyTextField(
                          controller: firstNameController,
                          hintText: 'First Name',
                          obsecuredText: false,
                          icon: Icons.person_outlined,
                        ),

                        MyTextField(
                          controller: lastNameController,
                          hintText: 'Last Name',
                          obsecuredText: false,
                          icon: Icons.person_outlined,
                        ),

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

                        MyTextField(
                          controller: confirmPassController,
                          hintText: 'Confirm Password',
                          obsecuredText: true,
                          icon: Icons.lock_outlined,
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
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                              ),
                              onPressed: () {
                                //Log in Users
                                signUpUsers();
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
                            const Text('Already have an account?'),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: widget.onTap,
                                child: Text(
                                  'Log In Now',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xFFF68922)),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 50.0),
                      ],
                    )),
              ),
            )));
  }
}
