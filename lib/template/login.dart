import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFFF9E3CE),
            body: Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 10, left: 10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Color(0xFF46474B),
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: () {
                          //forgot password screen
                        },
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Color(0xFFF68922),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 236, 153, 75)),
                          child: const Text('Login'),
                          onPressed: () {
                            print(nameController.text);
                            print(passwordController.text);
                            Navigator.pushNamed(context, '/home');
                          },
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Don\'t have an account?'),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextButton(
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFFF68922)),
                            ),
                            onPressed: () {
                              //signup screen
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ))));
  }
}
