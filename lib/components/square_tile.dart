import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String label;
  const SquareTile({super.key, required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.white,
        ),
        child: Row(children: [
          Image.asset(
            imagePath,
            height: 20.0,
          ),
          SizedBox(width: 10.0),
          Text(label)
        ]));
  }
}
