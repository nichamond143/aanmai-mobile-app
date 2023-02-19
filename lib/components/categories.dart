import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.heading,
    required this.color,
    required this.width,
    required this.categories,
  });

  final String heading;
  final Color color;
  final double width;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: width * 0.5,
                child: FittedBox(
                  child: Text(
                    heading,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              RichText(
                  text: TextSpan(
                      text: 'See More',
                      style: TextStyle(
                          color: color,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = () {}))
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (var category in categories)
                Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: color),
                        child: Text(
                          category,
                          style: TextStyle(fontSize: 15.0),
                        )))
            ],
          ),
        ),
      ],
    );
  }
}
