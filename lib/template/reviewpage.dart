import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
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
            child: Image.asset(
              "assets/images/bookcovers/catcherintherye.jpg",
              width: 200,
            ),
          ),
          Padding(
            //favorite button
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    click = !click;
                  });
                },
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                        (click == false)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white),
                  ),
                  Text('Add to Favorites')
                ])),
          ),
          Card(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
                child: Column(
                  children: [
                    Text(
                      'The Catcher in the Rye',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'J.D Salinger',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (var i = 0; i < 5; i++) ...[
                            if (i == 4) ...[
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
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: SizedBox(
                        width:
                            300, //width must be less than the width of Row(),
                        child: Text.rich(
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
                              TextSpan(
                                  text:
                                      'The novel details two days in the life of 16-year-old Holden Caulfield after he has been expelled from prep school.')
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300, //width must be less than the width of Row(),
                      child: Text.rich(
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
                            TextSpan(
                                text:
                                    'Catcher in the rye” is one of most debatable, argumentative, complex novels of the century.')
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                              TextSpan(
                                  text:
                                      'Novel, Bildungsroman, Coming-of-age story,'
                                      'Young adult fiction, First-person narrative, Literary'
                                      'realism')
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300, //width must be less than the width of Row(),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '234 pages,',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300, //width must be less than the width of Row(),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'First published July 16, 1951',
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
  }
}
