import 'package:aanmai_app/components/carousel.dart';
import 'package:aanmai_app/pages/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:aanmai_app/components/headings.dart';
import 'package:aanmai_app/components/item_row.dart';
import 'package:aanmai_app/components/categories_list.dart';
import '../components/featured.dart';
import '../components/navigationbar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstName = "";
  String fullName = "";
  String photoUrl = "";
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color pumpkin = theme.primaryColor;

    double width = MediaQuery.of(context).size.width;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    String uid = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder(
        future: users.doc(uid).get(),
        builder: (context, snapshot) {
          if (_isLoading) {
            return LoadingCat();
          } else {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            firstName = data['firstName'];
            fullName = "${data['firstName']} ${data['lastName']}";
            photoUrl = data['photoUrl'];
            return Scaffold(
              appBar: AppBar(leading: Builder(builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.sort, size: 40.0),
                  tooltip: 'Menu Icon',
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              })),
              drawer: HamburgerDrawer(
                name: fullName,
                photoUrl: photoUrl,
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: SizedBox(
                                  width: width * 0.75,
                                  child: FittedBox(
                                    child: Text(
                                      'Hi $firstName, \nWelcome Back!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 30.0),
                              child: Carousel()),
                          Genres(
                              heading: 'Book Genres',
                              color: pumpkin,
                              width: width),
                          Heading(
                            heading: 'Weekly Recommendations',
                            width: width,
                          ),
                          SubHeading(
                            subHeading:
                                'See our recommendations for this week!',
                            width: width,
                          ),
                          BookList(
                              collectionName: 'weekly',
                              documentName: 'recommendations'),
                          FeaturedBook(),
                          Heading(
                              heading: 'Halloween Specials', width: width),
                          SubHeading(
                            subHeading:
                                'See some of our most spooky recommendations!',
                            width: width,
                          ),
                          BookList(
                            collectionName: 'halloween',
                            documentName: 'recommendations',
                          ),
                          Industries(
                              heading: 'Industries',
                              color: pumpkin,
                              width: width),
                          Heading(heading: 'Featured People', width: width),
                          SubHeading(
                              subHeading:
                                  'See what our featured people have recommended',
                              width: width),
                          PeopleList(
                            collectionName: 'trending',
                          ),
                          SizedBox(height: 15.0),
                          FeaturedPeople(),
                          Heading(
                              heading: 'Famous People in Thailand',
                              width: width),
                          SubHeading(
                              subHeading:
                                  'See recommendations from people in Thailand!',
                              width: width),
                          PeopleList(
                            collectionName: 'famous-thais',
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: SizedBox.fromSize(
                                  size: Size(width, 275),
                                  child: Image.asset(
                                      'assets/images/backgrounds/feedback.jpg',
                                      fit: BoxFit.cover))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
