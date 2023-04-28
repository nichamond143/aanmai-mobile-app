import 'package:aanmai_app/pages/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PeopleCollection extends StatefulWidget {
  final String documentName;
  final String collectionName;
  final String? genreName;
  const PeopleCollection(
      {super.key,
      required this.documentName,
      required this.collectionName,
      this.genreName});

  @override
  State<PeopleCollection> createState() => _PeopleCollectionState();
}

class _PeopleCollectionState extends State<PeopleCollection> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('people')
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
                title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.genreName ?? widget.collectionName,
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 21),
                  ),
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
                        crossAxisCount: 2, mainAxisExtent: 230),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () {
                                //someone's recommendations
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecommendCollection(
                                            biography:
                                                documentSnapshot['biography'],
                                            profile:
                                                documentSnapshot['profile'],
                                            genreName:
                                                '${documentSnapshot['name']}\'s Book List',
                                            collectionName:
                                                documentSnapshot['name'],
                                          )),
                                );
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // Image border
                                      child: Image.network(
                                          documentSnapshot['profile'],
                                          fit: BoxFit.fill,
                                          height: 175,
                                          width: 175)),
                                  SizedBox(height: 10),
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(documentSnapshot['name']))
                                ],
                              )));
                    }),
              ),
            ),
          );
        });
  }
}

class RecommendCollection extends StatefulWidget {
  final String collectionName;
  final String biography;
  final String profile;
  final String? genreName;

  const RecommendCollection(
      {super.key,
      required this.collectionName,
      required this.biography,
      required this.profile,
      this.genreName});

  @override
  State<RecommendCollection> createState() => _RecommendCollectionState();
}

class _RecommendCollectionState extends State<RecommendCollection> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('books')
            .doc('recommendations')
            .collection(widget.collectionName)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (!streamSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 214, 161),
            appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0.0,
                centerTitle: true,
                title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.genreName ?? widget.collectionName,
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 21),
                  ),
                )),
            body: Column(
              children: [
                Expanded(
                  child: ListView(scrollDirection: Axis.vertical, children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                      child: FractionallySizedBox(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: SizedBox.fromSize(
                                size: Size(width, height * 0.3),
                                child: Image.network(widget.profile,
                                    fit: BoxFit.cover))),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            widget.collectionName,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 30, left: 30),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(widget.biography)),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Recommendations',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.65,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GridView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                                                builder: (context) =>
                                                    ReviewPage(
                                                      documentName:
                                                          'recommendations',
                                                      collectionName:
                                                          widget.collectionName,
                                                      documentId:
                                                          documentSnapshot.id,
                                                      thumbnail:
                                                          documentSnapshot[
                                                              'thumbnail'],
                                                      title: documentSnapshot[
                                                          'title'],
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
                      ),
                    ),
                  ]),
                )
              ],
            ),
          );
        });
  }
}

class GenreCollection extends StatefulWidget {
  final String documentName;
  final String collectionName;
  final String? genreName;

  const GenreCollection(
      {super.key,
      required this.documentName,
      required this.collectionName,
      this.genreName});

  @override
  State<GenreCollection> createState() => _GenreCollectionState();
}

class _GenreCollectionState extends State<GenreCollection> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final genre = FirebaseFirestore.instance
        .collection('books')
        .doc('library')
        .collection('genres');
    return FutureBuilder(
        future: genre.doc(widget.documentName).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
              backgroundColor: Color.fromARGB(255, 255, 218, 170),
              appBar: AppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0.0,
                  centerTitle: true,
                  title: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      widget.genreName ?? widget.collectionName,
                      style:
                          TextStyle(fontWeight: FontWeight.w200, fontSize: 21),
                    ),
                  )),
              body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child:
                          ListView(scrollDirection: Axis.vertical, children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                          child: Stack(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: SizedBox.fromSize(
                                    size: Size(width, 200),
                                    child: Image.network(data['thumbnail'],
                                        fit: BoxFit.cover))),
                            Positioned(
                              top: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['genre'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: width * 0.75,
                                        child: Text(data['caption'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w200)),
                                      )
                                    ]),
                              ),
                            )
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text('Recommendations',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height) * 0.7,
                          child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('books')
                                      .doc('library')
                                      .collection(widget.collectionName)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot>
                                          streamSnapshot) {
                                    if (!streamSnapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return GridView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 250,
                                        ),
                                        itemCount:
                                            streamSnapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          final DocumentSnapshot
                                              documentSnapshot =
                                              streamSnapshot.data!.docs[index];
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15, bottom: 15),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ReviewPage(
                                                                documentName:
                                                                    'library',
                                                                //'library',
                                                                collectionName:
                                                                    widget
                                                                        .collectionName,
                                                                //weeekly,
                                                                documentId:
                                                                    documentSnapshot
                                                                        .id,
                                                                thumbnail:
                                                                    documentSnapshot[
                                                                        'thumbnail'],
                                                                title:
                                                                    documentSnapshot[
                                                                        'title'],
                                                              )),
                                                    );
                                                  },
                                                  child: FractionallySizedBox(
                                                    widthFactor: 0.8,
                                                    heightFactor: 1.0,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20), // Image border
                                                        child: Image.network(
                                                            documentSnapshot[
                                                                'thumbnail'],
                                                            fit: BoxFit.fill,
                                                            height: 250)),
                                                  )));
                                        });
                                  })),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
