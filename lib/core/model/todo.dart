import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Todo with ChangeNotifier {
  String? todos;
  bool isChecked;

  Todo({this.todos, this.isChecked = false});

  factory Todo.fromFirestore(QueryDocumentSnapshot doc) {
    return Todo(todos: doc['todos'] ?? '', isChecked: doc['isChecked']);
  }

  Map<String, dynamic> toJson() {
    return {'todos': todos ?? '', 'isChecked': isChecked};
  }

  void isDone() {
    isChecked = !isChecked;
    notifyListeners();
  }
}
