import 'package:flutter/material.dart';
import 'package:todoapps/core/model/todo.dart';
import 'package:todoapps/core/services/database_service.dart';
import 'package:todoapps/ui/widgets/custom_floating_action_button.dart';
import 'package:todoapps/ui/widgets/todo_list.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    FirestoreService service = FirestoreService();
    Todo todo = Todo();
    Uuid uuid = Uuid();

    return Scaffold(
        appBar: AppBar(
          title: const Text('My Todos'),
        ),
        body: ListView(children: const [
          /// VIEW DATA HERE
          TodoList(),
        ]),
        floatingActionButton: const CustomFloatingActionButton());
  }
}
