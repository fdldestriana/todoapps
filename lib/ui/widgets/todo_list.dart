import 'package:flutter/material.dart';
import 'package:todoapps/core/model/todo.dart';
import 'package:todoapps/core/services/database_service.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    var firestore = FirestoreService();
    var todos = firestore.streamReadTodo();

    return StreamBuilder<List<Todo>>(
        stream: todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data!
                  .map((e) => Dismissible(
                      key: UniqueKey(),
                      child: Card(
                          elevation: 4,
                          child: CheckboxListTile(
                              title: Text(e.todos!),
                              value: e.isChecked,
                              onChanged: (value) {
                                setState(() {
                                  /// UPDATE DATA HERE
                                });
                              })),
                      // ignore: avoid_returning_null_for_void
                      onDismissed: (direction) =>

                          /// DELETE DATA HERE
                          setState(() {
                            firestore.deleteTodo(e.id);
                          })))
                  .toList(),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
