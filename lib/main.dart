import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/home_page.dart';

/// Entry point of the Flutter application.
void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo', // Application title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Defines the primary color scheme
      ),
      home: const HomePage(), // Sets the home page of the app
    );
  }
}
