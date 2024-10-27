import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'LocationSharingScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform) ;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Sharing App',
      home: LocationSharingScreen(),
    );
  }
}
