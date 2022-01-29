// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapps/core/model/todo.dart';

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final CollectionReference _reference = _firestore.collection('todos');

// class DatabaseService {
//   DatabaseService();

//   Future<void> deleteTodo() async {
//     await _reference.doc().delete();
//   }

//   Future<void> updateTodo(bool? value) async {
//     Map<String, bool> data = <String, bool>{'isChecked': value!};
//     await _reference.doc().collection('todos').doc().update(data);
//   }
// }

class FirestoreService {
  final CollectionReference reference =
      FirebaseFirestore.instance.collection('todos');

  /// Fetching stream data from firestore
  Stream<List<Todo>> streamReadTodo() {
    var todos = reference.snapshots();
    return todos
        .map((todo) => todo.docs.map((e) => Todo.fromFirestore(e)).toList());
  }

  /// Adding data to firestore
  Future<void> addTodo(Todo todo) async {
    await reference.doc(todo.id).set(todo.toJson());
  }

  /// Deleting data from firestore
  Future<void> deleteTodo(String? id) async {
    await reference.doc(id).delete();
  }

  /// Updating data from firestore
  Future<void> upadteTodo(Todo todo, bool value) async {
    todo.isChecked = value;
    await reference.doc(todo.id).update(todo.toJson());
  }
}
