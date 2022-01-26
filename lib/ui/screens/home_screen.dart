import 'package:flutter/material.dart';
import 'package:todoapps/core/model/todo.dart';
import 'package:todoapps/core/services/database_service.dart';
import 'package:todoapps/ui/widgets/todo_list.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
      ),
      body: ListView(children: const [
        /// VIEW DATA HERE
        TodoList(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text('Add Todos'),
                  content: TextField(
                    onChanged: (String text) {
                      todo.todos = text;
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          /// ADD DATA HERE
                          service.addTodo(todo);
                          todo.todos = '';
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
