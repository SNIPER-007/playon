import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PlayonApp());
}

class PlayonApp extends StatelessWidget {
  const PlayonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Playon',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF081626),
      ),
      home: const HomeScreen(),
    );
  }
}