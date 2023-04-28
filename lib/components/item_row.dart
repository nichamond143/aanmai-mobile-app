import 'package:aanmai_app/pages/review.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../pages/collections.dart';

class BookList extends StatefulWidget {
  BookList({
    super.key,
    required this.collectionName,
    required this.documentName,
  });

  final String collectionName;
  final String documentName;

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('books')
            .doc(widget.documentName)
            .collection(widget.collectionName)
            .where('title', isNotEqualTo: 'The Catcher in the Rye')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return SizedBox(
              height: 300.0,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Padding(
                        padding:
                            const EdgeInsets.only(right: 10.0, bottom: 35.0),
                        child: GestureDetector(
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(20), // Image border
                              child: Image.network(
                                  documentSnapshot['thumbnail'],
                                  fit: BoxFit.cover,
                                  height: 250)),
                          onTap: () {
                            //go to review page of book
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewPage(
                                          documentId: documentSnapshot.id,
                                          documentName: widget.documentName,
                                          collectionName: widget.collectionName,
                                          title: documentSnapshot['title'],
                                          thumbnail:
                                              documentSnapshot['thumbnail'],
                                        )));
                          },
                        ));
                  }),
            );
          } else if (streamSnapshot.hasError) {
            return Text(streamSnapshot.error.toString());
          } else {
            return Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 35.0),
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}

class PeopleList extends StatefulWidget {
  PeopleList({
    super.key,
    required this.collectionName,
  });

  final String collectionName;

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('people')
            .doc('featured')
            .collection(widget.collectionName)
            .where('name', isNotEqualTo: 'Kim Nam-joon')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return SizedBox(
              height: 225.0,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Padding(
                        padding:
                            const EdgeInsets.only(right: 10.0, bottom: 10.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecommendCollection(
                                                biography: documentSnapshot[
                                                    'biography'],
                                                profile:
                                                    documentSnapshot['profile'],
                                                genreName:
                                                    '${documentSnapshot['name']}\'s Book List',
                                                collectionName:
                                                    documentSnapshot['name'],
                                              )));
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        20), // Image border
                                    child: Image.network(
                                      documentSnapshot['profile'],
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: 175,
                                    )),
                              ),
                            ),
                            Text(documentSnapshot['name'])
                          ],
                        ));
                  }),
            );
          } else if (streamSnapshot.hasError) {
            return Text(streamSnapshot.error.toString());
          } else {
            return Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 35.0),
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}
