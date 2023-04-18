import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LoadingCat extends StatefulWidget {
  const LoadingCat({super.key});

  @override
  State<LoadingCat> createState() => _LoadingCatState();
}

class _LoadingCatState extends State<LoadingCat> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF9E3CE),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 200,
              child: Lottie.asset('assets/images/logos/14636-white-cat.json',
              fit: BoxFit.cover),
            ),
            Text('Finding the right books for you...',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Color.fromARGB(255, 0, 0, 0))),
            SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: LinearPercentIndicator(
                animation: true,
                animationDuration: 5000,
                lineHeight: 20,
                barRadius: const Radius.circular(16),
                percent: 1.0,
                progressColor: Color(0xFFF68922),
                backgroundColor: Colors.grey,
              ),
            ),
          ]),
        ));
  }
}
