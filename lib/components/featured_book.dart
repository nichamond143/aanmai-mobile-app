import 'package:aanmai_app/components/stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/review.dart';

class FeaturedBook extends StatelessWidget {
  const FeaturedBook({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = FirebaseFirestore.instance
        .collection('books')
        .doc('recommendations')
        .collection('weekly');
    return FutureBuilder(
        future: featured.doc('featuredBook').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> details =
              snapshot.data!.data() as Map<String, dynamic>;
          return SizedBox(
              height: 450,
              child: Card(
                  color: Color.fromARGB(255, 236, 153, 75),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Wrap(children: [
                      Row(children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, bottom: 20.0),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(10), // Image border
                              child: Image.network(details['thumbnail'],
                                  fit: BoxFit.cover, height: 250)),
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(details['title'],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(details['author']),
                            ),
                            StarRating(rating: details['rating']),
                          ],
                        ))
                      ]),
                      Text(
                        details['description'],
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReviewPage(
                                            documentId: 'featuredBook',
                                            documentName: 'recommendations',
                                            collectionName: 'weekly',
                                            title: details['title'],
                                            thumbnail: details['thumbnail'],
                                          )));
                            },
                            child: const Text('See More'),
                          ),
                          Icon(
                            Icons.navigate_next,
                          ),
                        ],
                      )
                    ]),
                  )));
        });
  }
}
