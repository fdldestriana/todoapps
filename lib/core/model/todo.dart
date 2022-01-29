import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Todo with ChangeNotifier {
  String? id;
  String? todos;
  bool isChecked;

  Todo({this.id, this.todos, this.isChecked = false});

  factory Todo.fromFirestore(QueryDocumentSnapshot doc) {
    return Todo(
        id: doc['id'], todos: doc['todos'] ?? '', isChecked: doc['isChecked']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'todos': todos ?? '', 'isChecked': isChecked};
  }

  void isDone() {
    isChecked = !isChecked;
    notifyListeners();
  }
}
