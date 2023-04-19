import 'package:aanmai_app/pages/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookGenre extends StatefulWidget {
  final String documentName;
  final String collectionName;
  final String? genreName;
  const BookGenre(
      {super.key,
      required this.documentName,
      required this.collectionName,
      this.genreName});

  @override
  State<BookGenre> createState() => _BookGenreState();
}

class _BookGenreState extends State<BookGenre> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('books')
            .doc(widget.documentName)
            .collection(widget.collectionName)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (!streamSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  widget.genreName ?? widget.collectionName,
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 21),
                )),
            body: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: 275),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReviewPage(
                                            documentName: widget.documentName,
                                            //'library',
                                            collectionName:
                                                widget.collectionName,
                                            //weeekly,
                                            documentId: documentSnapshot.id,
                                            thumbnail:
                                                documentSnapshot['thumbnail'],
                                            title: documentSnapshot['title'],
                                          )),
                                );
                              },
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(20), // Image border
                                  child: Image.network(
                                      documentSnapshot['thumbnail'],
                                      fit: BoxFit.fill,
                                      height: 250))));
                    }),
              ),
            ),
          );
        });
  }
}
