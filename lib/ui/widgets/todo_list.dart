import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapps/core/model/todo.dart';
import 'package:todoapps/core/services/database_service.dart';
import 'package:todoapps/ui/widgets/custom_dismissible.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todos = FirestoreService().streamReadTodo();

    return StreamBuilder<List<Todo>>(
        stream: todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: snapshot.data!
                    .map((e) => CustomDismissible(
                          todo: e,
                        ))
                    .toList());
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
