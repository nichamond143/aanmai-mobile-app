import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PeopleList extends StatefulWidget {
  PeopleList({
    super.key,
    required this.people,
  });

  final String people;

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection(widget.people).snapshots(),
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
                        child: Stack(children: [
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(20), // Image border
                              child: Image.asset(documentSnapshot['picture'],
                                  fit: BoxFit.cover, height: 200, width: 175,)),
                        ]));
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
