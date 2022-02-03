import 'package:flutter/material.dart';
import 'package:todoapps/core/model/todo.dart';
import 'package:todoapps/core/services/database_service.dart';

class CustomDismissible extends StatefulWidget {
  Todo todo = Todo();
  CustomDismissible({Key? key, required this.todo}) : super(key: key);

  @override
  State<CustomDismissible> createState() => _CustomDismissibleState();
}

class _CustomDismissibleState extends State<CustomDismissible> {
  @override
  Widget build(BuildContext context) {
    var firestore = FirestoreService();
    return Dismissible(
        key: UniqueKey(),
        child: Card(
            elevation: 4,
            color: (widget.todo.isChecked == true) ? Colors.cyan : Colors.white,
            child: CheckboxListTile(

                /// READ DATA HERE
                title: Text(
                  widget.todo.todos!,
                  style: TextStyle(
                      decoration: (widget.todo.isChecked == true)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                value: widget.todo.isChecked,

                /// UPDATE DATA HERE
                onChanged: (value) {
                  setState(() {
                    firestore.upadteTodo(widget.todo, value!);
                  });
                })),
        onDismissed: (direction) =>

            /// DELETE DATA HERE
            setState(() {
              firestore.deleteTodo(widget.todo.id);
            }));
  }
}
