import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<void> signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //Create a new creditial for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _users.doc(uid).set({
      "email": gUser.email,
      "firstName": getFirstName(gUser.displayName),
      "lastName": getLastName(gUser.displayName),
      "photoUrl": gUser.photoUrl,
      "uid": uid
    });

    print('User data saved');
  }

  Future<void> signInWithFacebook() async {
    final LoginResult fUser = await FacebookAuth.instance.login();
    final userData = await FacebookAuth.instance.getUserData();

    final credential =
        FacebookAuthProvider.credential(fUser.accessToken!.token);

    await FirebaseAuth.instance.signInWithCredential(credential);

    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _users.doc(uid).set({
      "email": userData['email'],
      "firstName": getFirstName(userData['name']),
      "lastName": getLastName(userData['name']),
      "photoUrl": userData['picture']['data']['url'],
      "uid": uid
    });

    print('User data saved');
  }

  String? getFirstName(String? fullName) {
    return fullName!.split(" ")[0];
  }

  String? getLastName(String? fullName) {
    return fullName!.split(" ")[1];
  }
}
