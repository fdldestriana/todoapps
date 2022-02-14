import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:todoapps/core/services/firestore_service.dart';
import 'package:todoapps/ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirestoreService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Flutter Todo App',
        home: HomePage(title: 'My Flutter Todo'),
      ),
    );
  }
}
