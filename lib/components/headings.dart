import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  const Heading({
    super.key,
    required this.heading,
    required this.width,
  });

  final String heading;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: [
          SizedBox(
              width: width * 0.8,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(heading,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              )),
        ],
      ),
    );
  }
}

class SubHeading extends StatelessWidget {
  const SubHeading({
    super.key,
    required this.subHeading,
    required this.width,
  });

  final String subHeading;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 25),
      child: SizedBox(
          width: width * 0.25,
          child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(subHeading, style: TextStyle(color: Colors.grey)))),
    );
  }
}
