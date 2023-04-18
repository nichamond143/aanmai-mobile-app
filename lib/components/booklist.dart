import 'package:aanmai_app/pages/review.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
