import 'package:flutter/material.dart';
import 'package:todoapps/core/model/todo.dart';
import 'package:todoapps/core/services/database_service.dart';
import 'package:uuid/uuid.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Todo todo = Todo();
    Uuid uuid = const Uuid();
    var firestore = FirestoreService();
    return FloatingActionButton(
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
                    todo.id = uuid.v4();
                  },
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        /// ADD DATA HERE
                        firestore.addTodo(todo);
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
    );
  }
}
