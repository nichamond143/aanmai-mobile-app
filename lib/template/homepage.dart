import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:async' show Future;
import 'package:aanmai_app/components/headings.dart';
import 'package:aanmai_app/components/booklist.dart';

import 'layout.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dataFromFile = "";
  Future<void> readText() async {
    final String response =
        await rootBundle.loadString('assets/reviews/warcross.txt');
    setState(() {
      dataFromFile = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    readText();
    var appState = context.watch<MyAppState>();

    var weeklyRec = appState.weeklyRec;
    var valentine = appState.valentineDay;

    String heading1 = "Weekly Must Reads";
    String subHeading1 = "See our recommendation for this week!";
    String heading2 = "Valentine Day Specials";
    String subHeading2 = "See some of our most romantic recommendations!";

    var theme = Theme.of(context);
    Color pumpkin = theme.primaryColor;

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Row(
              children: [
                SizedBox(
                  width: width * 0.75,
                  child: FittedBox(
                    child: Text(
                      'Hi Annabeth, \nWelcome Back!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0, bottom: 30.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: SizedBox.fromSize(
                      size: Size(width, 200),
                      child: Image.asset('assets/images/AANMAI.jpg',
                          fit: BoxFit.cover))),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                    child: FittedBox(
                      child: Text(
                        'Book Genres',
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
                              color: pumpkin,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = () {}))
                ],
              ),
            ),
            Row(
              children: <Widget>[
                for (var i = 0; i < 4; i++)
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: pumpkin),
                            child: FittedBox(child: Text(appState.genre[i])))),
                  )
              ],
            ),
            Heading(
              heading: heading1,
              color: pumpkin,
              width: width,
            ),
            SubHeading(
              subHeading: subHeading1,
              width: width,
            ),
            BookList(bookCovers: weeklyRec),
            SizedBox(
                height: 450,
                child: Card(
                    color: pumpkin,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(children: [
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, bottom: 20.0),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10), // Image border
                                child: Image.asset('assets/images/warcross.jpg',
                                    fit: BoxFit.cover, height: 250)),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Warcross',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text('Marie Lu'),
                              ),
                              Row(
                                children: [
                                  for (var i = 0; i < 5; i++) ...[
                                    if (i == 4) ...[
                                      Icon(Icons.star_rate, color: Colors.grey)
                                    ] else ...[
                                      Icon(Icons.star_rate,
                                          color: Colors.yellow)
                                    ]
                                  ]
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, bottom: 15.0),
                                  child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: Colors.white),
                                      child: Text('Add to Favorites',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))))
                            ],
                          ))
                        ]),
                        Text(
                          dataFromFile,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'See More',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {})),
                            Icon(
                              Icons.navigate_next,
                            ),
                          ],
                        )
                      ]),
                    ))),
            Heading(heading: heading2, color: pumpkin, width: width),
            SubHeading(
              subHeading: subHeading2,
              width: width,
            ),
            BookList(bookCovers: valentine),
            ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: SizedBox.fromSize(
                    size: Size(width, 250),
                    child: Image.asset('assets/images/bookclub.jpg',
                        fit: BoxFit.cover))),
          ],
        ),
      ),
    );
  }
}
