import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String? todos;
  bool? isChecked;

  Todo({this.todos, this.isChecked});

  factory Todo.fromFirestore(QueryDocumentSnapshot doc) {
    return Todo(
        todos: doc['todos'] ?? '', isChecked: doc['isChecked'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {'todos': todos ?? '', 'isChecked': isChecked ?? false};
  }
}
