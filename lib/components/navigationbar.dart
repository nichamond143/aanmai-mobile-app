import 'package:aanmai_app/pages/coming_soon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/favorites.dart';
import '../pages/home.dart';

class HamburgerDrawer extends StatefulWidget {
  const HamburgerDrawer({
    super.key,
    required this.name,
    required this.photoUrl,
  });

  final String? name;
  final String photoUrl;

  @override
  State<HamburgerDrawer> createState() => _HamburgerDrawerState();
}

class _HamburgerDrawerState extends State<HamburgerDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          buildHeader(context, widget.name, widget.photoUrl),
          buildMenuItems(context),
        ],
      )));
}

//Log Users Out
void logUserOut() {
  FirebaseAuth.instance.signOut();
}

//Profile Picture and Name
Widget buildHeader(BuildContext context, String? name, String photoUrl) =>
    Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          // Navigate to user page
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FavoritesPage()));
        },
        child: Container(
            color: Color.fromARGB(255, 251, 248, 244),
            padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(photoUrl),
                ),
                SizedBox(height: 12),
                Text(name ?? 'User123',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold))
              ],
            )),
      ),
    );

//Drawer Menu Items
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
                    MaterialPageRoute(builder: (context) => FavoritesPage()));
              }),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.local_library_outlined),
              title: const Text('Book Club',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ComingSoon(title: 'Book Club')));
              }),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.checklist_rtl_outlined),
              title: const Text('Activities',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ComingSoon(title: 'Activities')));
              }),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.newspaper_outlined),
              title: const Text('News',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ComingSoon(title: 'News')));
              }),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ComingSoon(title: 'Settings')));
              }),
          ListTile(
              iconColor: Colors.orangeAccent,
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              onTap: () => logUserOut())
        ],
      ),
    );
