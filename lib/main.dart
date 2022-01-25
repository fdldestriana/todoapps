import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapps/services/database_service.dart';
import 'package:todoapps/ui/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: DatabaseService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter My Todo Apps',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: const HomePage(title: 'Flutter My Todos'),
      ),
    );
  }
}
