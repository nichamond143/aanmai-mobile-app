import 'package:aanmai_app/pages/loading.dart';
import 'package:aanmai_app/auth/auth_page.dart';
import 'package:aanmai_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forgot_password.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Aan Mai',
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Poppins',
            primaryColor: Color.fromARGB(255, 236, 153, 75),
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(255, 236, 153, 75)),
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              color: Color.fromARGB(220, 236, 153, 75), //<-- SEE HERE
            )),
        initialRoute: '/',
        routes: {
          '/': (context) => LandingPage(),
          '/loading': (context) => LoadingCat(),
          '/authen': (context) => AuthPage(),
          '/home': (context) => HomePage(),
          '/resetPassword': (context) => ForgotPasswordPage(),
        });
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color pumpkin = theme.primaryColor;

    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
      Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage("assets/images/backgrounds/landingpage-cat.jpg"),
              fit: BoxFit.cover),
        ),
      ),
      Positioned(
        bottom: 50,
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            '"Today a reader, tomorrow a leader."\n-Margaret Fuller',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: pumpkin, minimumSize: Size.fromHeight(50)),
                onPressed: () {
                  Get.to(() => AuthPage(),
                      transition: Transition.downToUp,
                      duration: Duration(seconds: 1));
                },
                child: Text(
                  'Let\'s go',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                )),
          )
        ]),
      ),
    ]));
  }
}
