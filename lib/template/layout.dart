import 'package:aanmai_app/template/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Aan Mai',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          primaryColor: Color.fromARGB(255, 236, 153, 75),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 236, 153, 75)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// Define app's state (ChangeNotifier)
class MyAppState extends ChangeNotifier {
  // Data variable app needs to function

  var genre = <String>[
    'Fantasy',
    'Sci-Fi',
    'Dystopian',
    'Romance',
    'Adventure',
    'Mystery',
    'Horror',
    'Thriller',
    'LGBTQ+',
    'Historical Fiction',
    'Young Adult'
  ];

  var weeklyRec = <String>[
    'assets/images/hailprojectmary.jpg',
    'assets/images/markofathena.jpg',
    'assets/images/fightclub.jpg',
    'assets/images/evelynhugo.jpg',
    'assets/images/warcross.jpg'
  ];

  var valentineDay = <String>[
    'assets/images/annaAndTheFrenchKiss.jpg',
    'assets/images/tooalltheboys.jpg',
    'assets/images/thekissquotient.jpg',
    'assets/images/geekerella.jpg',
    'assets/images/theselection.jpg'
  ];
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.sort, size: 40.0),
                tooltip: 'Menu Icon',
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            actions: <Widget>[
              Icon(Icons.notifications_none, size: 35.0),
            ]),
        drawer: HamburgerDrawer(),
        body: HomePage(),
      );
    });
  }
}
