import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FeaturedPeople extends StatelessWidget {
  FeaturedPeople({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = FirebaseFirestore.instance
        .collection('people')
        .doc('featured')
        .collection('trending');
    return FutureBuilder(
        future: featured.doc('featuredPeople').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> details =
              snapshot.data!.data() as Map<String, dynamic>;
          return SizedBox(
              height: 400,
              child: Card(
                  color: Color.fromARGB(255, 236, 153, 75),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(children: [
                      Row(children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, bottom: 20.0),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(10), // Image border
                              child: Image.network(details['profile'],
                                  fit: BoxFit.cover, height: 200)),
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(details['name'],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(details['occupation']),
                            ),
                          ],
                        ))
                      ]),
                      Text(
                        details['biography'],
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
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
                        ),
                      )
                    ]),
                  )));
        });
  }
}
