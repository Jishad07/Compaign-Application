import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod


import 'views/homescreen/homescreen.dart'; // Import your form screen

void main() {
  runApp(
   const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campaign Form',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FormScreen(), // Your FormScreen widget
    );
  }
}
