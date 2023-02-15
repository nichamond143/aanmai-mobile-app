import 'package:flutter/material.dart';
import 'favoritespage.dart';
import 'homepage.dart';

class HamburgerDrawer extends StatefulWidget {
  const HamburgerDrawer({
    super.key,
  });

  @override
  State<HamburgerDrawer> createState() => _HamburgerDrawerState();
}

class _HamburgerDrawerState extends State<HamburgerDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      )));
}

Widget buildHeader(BuildContext context) => Material(
      color: Colors.orangeAccent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          // Navigate to user page
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FavoritesPage()));
        },
        child: Container(
            padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(
                      'https://qph.cf2.quoracdn.net/main-qimg-ec8edeb42bf09fbcb34c3ca7b6f623b5-lq'),
                ),
                SizedBox(height: 12),
                Text('Annabeth Chase',
                    style: TextStyle(fontSize: 24, color: Colors.white))
              ],
            )),
      ),
    );

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()))),
          ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Placeholder()));
              })
        ],
      ),
    );
