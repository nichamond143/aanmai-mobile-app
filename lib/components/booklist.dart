import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookList extends StatefulWidget {
  BookList({
    super.key,
    required this.bookList,
  });

  final String bookList;

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  bool click = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection(widget.bookList).snapshots(),
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
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Image border
                            child: Image.network(documentSnapshot['thumbnail'],
                                fit: BoxFit.cover, height: 250)));
                  }),
            );
          } else if (streamSnapshot.hasError) {
            return Text(streamSnapshot.error.toString());
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        });

    // SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: [
    //       for (var img in widget.bookCovers)
    //         Padding(
    //           padding: const EdgeInsets.only(right: 10.0, bottom: 35.0),
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(20), // Image border
    //             child: Stack(children: [
    //               Image.asset(img, fit: BoxFit.cover, height: 250),
    //               Positioned(
    //                 right: 15,
    //                 bottom: 15,
    //                 child: ClipOval(
    //                   child: Container(
    //                     color: Color.fromARGB(255, 236, 153, 75),
    //                     width: 60,
    //                     height: 60,
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                   right: 18,
    //                   bottom: 15,
    //                   child: IconButton(
    //                     onPressed: () {
    //                       setState(() {
    //                         click = !click;
    //                       });
    //                     },
    //                     icon: Icon(
    //                         (click == false)
    //                             ? Icons.favorite
    //                             : Icons.favorite_border,
    //                         color: Colors.white,
    //                         size: 40.0),
    //                   )),
    //             ]),
    //           ),
    //         )
    //     ],
    //   ),
    // );
  }
}
