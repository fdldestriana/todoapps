import 'package:flutter/material.dart';
import 'package:todoapps/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter My Todo Apps',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const HomePage(title: 'Flutter My Todos'),
    );
  }
}
