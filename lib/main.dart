import 'package:flutter/material.dart';
import 'package:tekber_markas/screens/homepage.dart';
import 'screens/start_screen.dart'; // Import ProfileScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),


      home: HomePage(),
    );
  }
}