import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/todo.dart';

class FirestoreService with ChangeNotifier {
  final CollectionReference reference =
      FirebaseFirestore.instance.collection('todos');

  ///Fetching stream data from firestore
  Stream<List<Todo>> streamReadTodo() {
    var todos = reference.snapshots();
    return todos
        .map((todo) => todo.docs.map((e) => Todo.fromFirestore(e)).toList());
    // ignore: dead_code
    notifyListeners();
  }

  ///Adding data to firestore
  Future<void> addTodo(Todo todo) async {
    await reference.doc(todo.id).set(todo.toJson());
    notifyListeners();
  }

  ///Deleting data from firestore
  Future<void> deleteTodo(String? id) async {
    await reference.doc(id).delete();
    notifyListeners();
  }

  ///Updating data in firestore
  Future<void> updateTodo(Todo todo) async {
    todo.isDone();
    await reference.doc(todo.id).update(todo.toJson());
    notifyListeners();
  }
}
