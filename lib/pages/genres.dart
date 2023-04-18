import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                              );
                            }))
                  ],
                ),
              );
            }));
  }
}
