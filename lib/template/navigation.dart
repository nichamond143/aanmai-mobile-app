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
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold))
              ],
            )),
      ),
    );

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()))),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.favorite_border),
              title: const Text('Favorites',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Placeholder()));
              }),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.local_library_outlined),
              title: const Text('Book Club',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Placeholder()));
              }),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.checklist_rtl_outlined),
              title: const Text('Activities',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Placeholder()));
              }),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.newspaper_outlined),
              title: const Text('News',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Placeholder()));
              }),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Placeholder()));
              }),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () => Navigator.pushNamed(context, '/login'))
        ],
      ),
    );
