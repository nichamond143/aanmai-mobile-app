import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'collections.dart';

class GenresPage extends StatefulWidget {
  GenresPage({super.key});

  @override
  State<GenresPage> createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Genres'),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('books')
                .doc('library')
                .collection('genres')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (!streamSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: SizedBox(
                                  height: 125,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GenreCollection(
                                                    documentName:
                                                        documentSnapshot.id,
                                                    collectionName:
                                                        documentSnapshot[
                                                            'genre'],
                                                  )));
                                    },
                                    child: Card(
                                      elevation: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              documentSnapshot['thumbnail'],
                                            ),
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            documentSnapshot['genre'],
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }))
                  ],
                ),
              );
            }));
  }
}

class IndustriesPage extends StatefulWidget {
  IndustriesPage({super.key});

  @override
  State<IndustriesPage> createState() => _IndustriesPageState();
}

class _IndustriesPageState extends State<IndustriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Industries'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('people')
                  .doc('sectors')
                  .collection('industries')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, mainAxisExtent: 150),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Padding(
                          padding: const EdgeInsets.all(5),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PeopleCollection(
                                              documentName: 'sectors',
                                              collectionName:
                                                  documentSnapshot['industry'],
                                            )));
                              },
                              child: SizedBox(
                                child: Stack(children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // Image border
                                      child: Image.network(
                                          documentSnapshot['thumbnail'],
                                          fit: BoxFit.fill,
                                          height: 250)),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              documentSnapshot['industry'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ])
                                ]),
                              )));
                    });
              }),
        ));
  }
}
