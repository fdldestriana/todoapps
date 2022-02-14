import 'package:flutter/material.dart';
import 'package:todoapps/core/models/todo.dart';
import 'package:todoapps/core/services/firestore_service.dart';

class CustomDismissible extends StatefulWidget {
  Todo todo = Todo();
  CustomDismissible({Key? key, required this.todo}) : super(key: key);

  @override
  _CustomDismissibleState createState() => _CustomDismissibleState();
}

class _CustomDismissibleState extends State<CustomDismissible> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckBoxTheme = theme.checkboxTheme;
    final newCheckBoxTheme = oldCheckBoxTheme.copyWith(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)));
    var firestore = FirestoreService();
    return Dismissible(
      key: UniqueKey(),
      child: Card(
        color: const Color(0xFF212121),
        elevation: 4,
        child: Theme(
            data: theme.copyWith(checkboxTheme: newCheckBoxTheme),
            child: CheckboxListTile(
                selectedTileColor: Colors.amber,
                checkColor: Colors.white,
                activeColor: const Color(0xFFB39DDB),

                ///Read data here
                title: Text(
                  widget.todo.todos!,
                  style: (widget.todo.isChecked == true)
                      ? (const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.blueGrey))
                      : (const TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white)),
                ),
                value: widget.todo.isChecked,

                ///Update data here
                onChanged: (value) {
                  setState(() {
                    firestore.updateTodo(widget.todo);
                  });
                })),
      ),

      ///Delete data here
      onDismissed: (direction) {
        setState(() {
          firestore.deleteTodo(widget.todo.id);
        });
      },
    );
  }
}
