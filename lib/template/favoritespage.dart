import 'package:aanmai_app/provider/favorite_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  final CollectionReference _favorites =
      FirebaseFirestore.instance.collection('favorites');

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
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
            stream:
                FirebaseFirestore.instance.collection('favorites').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                  child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, mainAxisExtent: 200),
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        final String bookTitle = documentSnapshot['title'];
                        return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Image border
                                    child: Image.asset(
                                      documentSnapshot['thumbnail'],
                                      fit: BoxFit.cover,
                                      height: 250,
                                    )),
                                Positioned(
                                  right: 10,
                                  bottom: 10,
                                  child: ClipOval(
                                    child: Container(
                                      color: Color.fromARGB(255, 236, 153, 75),
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 10,
                                    bottom: 10,
                                    child: IconButton(
                                      onPressed: () async {
                                        provider.toggleFavorite(bookTitle);
                                        await _favorites
                                            .doc(documentSnapshot.id)
                                            .delete();
                                      },
                                      icon: provider.isExist(bookTitle)
                                          ? const Icon(Icons.favorite,
                                              color: Colors.red, size: 25.0)
                                          : const Icon(Icons.favorite_border,
                                              color: Colors.white, size: 25.0),
                                    )),
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
            }));
  }
}
