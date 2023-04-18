import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(20), // Image border
                                  child: Image.network(
                                    documentSnapshot['profile'],
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 175,
                                  )),
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
