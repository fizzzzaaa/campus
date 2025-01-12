import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'package:campus/loginscreen.dart'; // Import the login screen
import 'package:campus/splash.dart'; // Import the splash screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that Firebase is initialized before the app runs
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'Campus Life Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Set SplashScreen as the initial screen
    );
  }
}
