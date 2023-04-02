import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/landing.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDIfLn1PvLu8_c1HOKX1IrS_kc-bpwEBLg',
          projectId: 'aan-mai-app-64ede',
          messagingSenderId: '',
          appId: '1:968111616162:android:c2a5586bc60100fbf467fb'));
  runApp(MyApp());
}
