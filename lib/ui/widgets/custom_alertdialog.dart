import 'package:flutter/material.dart';
import 'package:todoapps/core/models/todo.dart';
import 'package:todoapps/core/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Todo todo = Todo();
    Uuid uuid = const Uuid();
    var firestore = FirestoreService();
    return AlertDialog(
      backgroundColor: const Color(0xFF212121),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Center(
        child: Text(
          'Add Todos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      content: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
        onChanged: (String text) {
          todo.todos = text;
          todo.id = uuid.v4();
        },
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              ///Add data here
              firestore.addTodo(todo);
              todo.todos = '';
              Navigator.of(context).pop();
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
