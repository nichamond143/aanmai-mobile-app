import 'package:aanmai_app/pages/bookgenre.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  const Heading({
    super.key,
    required this.heading,
    required this.collectionName,
    required this.color,
    required this.width,
  });

  final String collectionName;
  final String heading;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: [
          SizedBox(
              width: width * 0.6,
              child: FittedBox(
                child: Text(heading,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )),
          Expanded(child: SizedBox()),
          RichText(
              text: TextSpan(
                  text: 'See More',
                  style: TextStyle(
                      color: color,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookGenre(
                                    genreName: heading,
                                    collectionName: collectionName,
                                    documentName: 'recommendations',
                                  )));
                    }))
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
              child: Text(subHeading, style: TextStyle(color: Colors.grey)))),
    );
  }
}
