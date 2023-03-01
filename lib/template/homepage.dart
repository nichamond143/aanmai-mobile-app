import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:async' show Future;
import 'package:aanmai_app/components/headings.dart';
import 'package:aanmai_app/components/booklist.dart';
import 'package:aanmai_app/components/categories.dart';
import 'package:aanmai_app/components/peoplelist.dart';
import 'layout.dart';
import 'navigation.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String reviewtxt = "";
  String biotxt = "";

  Future<void> readFile() async {
    final String review =
        await rootBundle.loadString('assets/longtext/catcherintherye.txt');
    final String bio =
        await rootBundle.loadString('assets/longtext/malalabio.txt');
    setState(() {
      reviewtxt = review;
      biotxt = bio;
    });
  }

  @override
  Widget build(BuildContext context) {
    readFile();

    var appState = context.watch<MyAppState>();

    var genre = <String>[
      'Fantasy',
      'Sci-Fi',
      'Dystopian',
      'Romance',
      'Adventure',
      'Mystery',
      'Horror',
      'Thriller',
      'LGBTQ+',
      'Historical Fiction',
      'Young Adult'
    ];

    var industries = <String>[
      'Activism',
      'Entrepreneur',
      'Influencer',
      'Artist',
      'Athletes',
      'Education',
      'Film',
      'Comedy',
      'Science',
      'Politics',
      'Technology'
    ];

    var featured = <String>[
      'assets/images/people/grethathunberg.png',
      'assets/images/people/bill.jpg',
      'assets/images/people/jordanpeele.jpg',
      'assets/images/people/taylorswift.jpg',
      'assets/images/people/maya-angelou.jpg'
    ];

    var featuredName = <String>[
      'Greta Thunberg',
      'Bill Gates',
      'Jordan Peele',
      'Taylor Swift',
      'Maya Angelou',
    ];

    var famousThais = <String>[
      'assets/images/people/JenniferPaweensuda.jpg',
      'assets/images/people/Kanatip.png',
      'assets/images/people/Pita.jpg',
      'assets/images/people/davika.jpg',
      'assets/images/people/Ariya-Banomyong.jpg'
    ];

    var thaiNames = <String>[
      'Paweensuda Drouin',
      'Kanatip Soonthornrak',
      'Pita Limjaroenrat',
      'Davika Hoorne',
      'Ariya Banomyong',
    ];

    var theme = Theme.of(context);
    Color pumpkin = theme.primaryColor;

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.sort, size: 40.0),
              tooltip: 'Menu Icon',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          actions: <Widget>[
            Icon(Icons.notifications_none, size: 35.0),
          ]),
      drawer: HamburgerDrawer(),
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
                      child: Image.asset('assets/images/backgrounds/AANMAI.jpg',
                          fit: BoxFit.cover))),
            ),
            Categories(
                heading: 'Book Genres',
                color: pumpkin,
                width: width,
                categories: genre),
            Heading(
              heading: 'Recommended For You',
              color: pumpkin,
              width: width,
            ),
            SubHeading(
              subHeading: 'See recommendations curated just for you!',
              width: width,
            ),
            BookList(bookList: "weeklyRecommend"),
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
                                child: Image.asset(
                                    'assets/images/bookcovers/catcherintherye.jpg',
                                    fit: BoxFit.cover,
                                    height: 250)),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('The Catcher in the Rye',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text('J.D. Salinger'),
                              ),
                              Row(
                                children: [
                                  for (var i = 0; i < 5; i++) ...[
                                    if (i == 4) ...[
                                      Icon(Icons.star_rate,
                                          color: Colors.grey, size: 16)
                                    ] else ...[
                                      Icon(Icons.star_rate,
                                          color: Colors.yellow, size: 16)
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
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold))))
                            ],
                          ))
                        ]),
                        Text(
                          reviewtxt,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/review');
                              },
                              child: const Text('See More'),
                            ),
                            Icon(
                              Icons.navigate_next,
                            ),
                          ],
                        )
                      ]),
                    ))),
            Heading(
                heading: 'Valentine Day Specials',
                color: pumpkin,
                width: width),
            SubHeading(
              subHeading: 'See some of our most romantic recommendations!',
              width: width,
            ),
            BookList(bookList: "valentineDay"),
            Categories(
                heading: 'Industries',
                color: pumpkin,
                width: width,
                categories: industries),
            Heading(heading: 'Featured People', color: pumpkin, width: width),
            SubHeading(
                subHeading: 'See what our featured people have recommended',
                width: width),
            PeopleList(pictures: featured, names: featuredName),
            SizedBox(
                height: 400,
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
                                child: Image.asset(
                                    'assets/images/people/malala.jpg',
                                    fit: BoxFit.cover,
                                    height: 200)),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Malala Yousafzai',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text('Pakistani Education Activist'),
                              ),
                            ],
                          ))
                        ]),
                        Text(
                          biotxt,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'See Their Recommendations',
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
            Heading(
                heading: 'Famous People in Thailand',
                color: pumpkin,
                width: width),
            SubHeading(
                subHeading: 'See recommendations from people in Thailand!',
                width: width),
            PeopleList(pictures: famousThais, names: thaiNames),
            ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: SizedBox.fromSize(
                    size: Size(width, 250),
                    child: Image.asset('assets/images/backgrounds/bookclub.jpg',
                        fit: BoxFit.cover))),
          ],
        ),
      ),
    );
  }
}
