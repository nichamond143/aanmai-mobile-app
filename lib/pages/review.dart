import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  final String documentName;
  final String collectionName;
  final String documentId;
  final String title;
  final String thumbnail;

  ReviewPage(
      {super.key,
      required this.documentName,
      required this.collectionName,
      required this.documentId,
      required this.title,
      required this.thumbnail});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  String? item = 'Buy from these retailers';

  bool click = true;

  // List of items in our dropdown menu
  List items = [
    'Buy from these retailers',
    'Lazada',
    'Shopee',
    'SE-ED',
    'B2S',
    'นายอินทร์'
  ];

  Future addToFavorites() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users-favorites');
    return collectionRef
        .doc(currentUser!.uid)
        .collection('favoriteBooks')
        .doc(widget.documentId)
        .set({
      "id": widget.documentId,
      "title": widget.title,
      "collection": widget.collectionName,
      "thumbnail": widget.thumbnail,
      "document": widget.documentName,
    }).then((value) => print("Added to Favorites"));
  }

  Future removeFromFavorites() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users-favorites');
    return collectionRef
        .doc(currentUser!.uid)
        .collection('favoriteBooks')
        .doc(widget.documentId)
        .delete()
        .then((value) => print("Remove from Favorites"));
  }

  @override
  Widget build(BuildContext context) {
    final books = FirebaseFirestore.instance
        .collection('books')
        .doc(widget.documentName)
        .collection(widget.collectionName);
    return FutureBuilder(
        future: books.doc(widget.documentId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> details =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
                //<Widget>[]
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0.0),
            body: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Align(
                  //book picture
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Image border
                      child: Image.network(details['thumbnail'],
                          fit: BoxFit.cover, height: 350)),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users-favorites')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('favoriteBooks')
                        .where('title', isEqualTo: widget.title)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Text("");
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: Size.fromHeight(45)),
                          onPressed: () {
                            snapshot.data.docs.length == 0
                                ? addToFavorites()
                                : removeFromFavorites();
                          },
                          icon: snapshot.data.docs.length == 0
                              ? Icon(Icons.favorite_outline,
                                  color: Colors.black)
                              : Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                          label: Text('Add to Favorites',
                              style: TextStyle(fontSize: 20.0)), // <-- Text
                        ),
                      );
                    }),
                Card(
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                            child: Text(
                              details['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            details['author'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (var i = 1; i <= 5; i++) ...[
                                  if (i > details['rating']) ...[
                                    Icon(Icons.star_rate, color: Colors.grey)
                                  ] else ...[
                                    Icon(Icons.star_rate, color: Colors.yellow)
                                  ]
                                ]
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(229, 166, 107, 1),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(15)),
                              child: DropdownButton(
                                hint: Text('Buy from these retailers'),
                                dropdownColor: Colors.white,
                                value: item,
                                items: items
                                    .map((item) => DropdownMenuItem(
                                        value: item, child: Text(item)))
                                    .toList(),
                                onChanged: ((value) =>
                                    setState(() => item = value.toString())),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: SizedBox(
                              width:
                                  300, //width must be less than the width of Row(),
                              child: Text.rich(
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Description : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Color.fromRGBO(229, 166, 107, 1),
                                      ),
                                    ),
                                    TextSpan(text: details['description'])
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                300, //width must be less than the width of Row(),
                            child: Text.rich(
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Review : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color.fromRGBO(229, 166, 107, 1),
                                    ),
                                  ),
                                  TextSpan(text: details['review'])
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: SizedBox(
                              width:
                                  300, //width must be less than the width of Row(),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Genre : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(text: details['genre'])
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                300, //width must be less than the width of Row(),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${details['pages']} pages",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                300, //width must be less than the width of Row(),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'First published in ${details['publishDate']}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
