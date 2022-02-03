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
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    );
    var firestore = FirestoreService();
    return Dismissible(
        key: UniqueKey(),
        child: Card(
            elevation: 4,
            child: Theme(
              data: theme.copyWith(checkboxTheme: newCheckBoxTheme),
              child: CheckboxListTile(
                  selectedTileColor: Colors.amber,
                  checkColor: Colors.white,
                  activeColor: Colors.lightGreen,
                  // selected: true,

                  /// READ DATA HERE
                  title: Text(
                    widget.todo.todos!,
                    style: (widget.todo.isChecked == true)
                        ? (const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.blueGrey))
                        : (const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black)),
                  ),
                  value: widget.todo.isChecked,

                  /// UPDATE DATA HERE
                  onChanged: (value) {
                    setState(() {
                      firestore.upadteTodo(widget.todo, value!);
                    });
                  }),
            )),
        onDismissed: (direction) =>

            /// DELETE DATA HERE
            setState(() {
              firestore.deleteTodo(widget.todo.id);
            }));
  }
}
