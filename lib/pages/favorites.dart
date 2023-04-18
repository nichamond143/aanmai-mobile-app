import 'package:aanmai_app/pages/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'Favorites',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users-favorites')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('favoriteBooks')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return Container(
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
                                                collectionName:
                                                    documentSnapshot[
                                                        'collection'],
                                                documentId:
                                                    documentSnapshot['id'],
                                                documentName: documentSnapshot[
                                                    'document'],
                                                thumbnail: documentSnapshot[
                                                    'thumbnail'],
                                                title:
                                                    documentSnapshot['title'],
                                              )),
                                    );
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // Image border
                                      child: Image.network(
                                          documentSnapshot['thumbnail'],
                                          fit: BoxFit.fill,
                                          height: 250))));
                        }),
                  ),
                );
              } else if (streamSnapshot.hasError) {
                return Text(streamSnapshot.error.toString());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
