import 'package:flutter/material.dart';
import 'screens/news_card_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Card App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsCardScreen(),
    );
  }
}
