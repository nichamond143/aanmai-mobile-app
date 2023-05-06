import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  final String title;
  const ComingSoon({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Coming Soon!')),
            ],
          ),
        ));
  }
}
