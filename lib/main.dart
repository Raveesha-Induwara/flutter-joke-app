import 'package:flutter/material.dart';
import 'package:joke_app/pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Joke App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:  const HomePage(),
    );
  }
}
