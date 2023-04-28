import 'package:aanmai_app/pages/categories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../pages/collections.dart';

class Genres extends StatelessWidget {
  const Genres({
    super.key,
    required this.heading,
    required this.color,
    required this.width,
  });

  final String heading;
  final Color color;
  final double width;

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
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GenresPage()));
                        }))
            ],
          ),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('books')
              .doc('library')
              .collection('genres')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (!streamSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GenreCollection(
                                              documentName: documentSnapshot.id,
                                              collectionName:
                                                  documentSnapshot['genre'],
                                            )));
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: color),
                              child: Text(
                                documentSnapshot['genre'],
                                style: TextStyle(fontSize: 15.0),
                              )),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }
}

class Industries extends StatelessWidget {
  const Industries({
    super.key,
    required this.heading,
    required this.color,
    required this.width,
  });

  final String heading;
  final Color color;
  final double width;

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
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndustriesPage()));
                        }))
            ],
          ),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('people')
              .doc('sectors')
              .collection('industries')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (!streamSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PeopleCollection(
                                              documentName: 'sectors',
                                              collectionName:
                                                  documentSnapshot['industry'],
                                            )));
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: color),
                              child: Text(
                                documentSnapshot['industry'],
                                style: TextStyle(fontSize: 15.0),
                              )),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }
}
