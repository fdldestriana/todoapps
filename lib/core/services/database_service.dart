import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapps/core/model/todo.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _reference = _firestore.collection('todos');

class DatabaseService with ChangeNotifier {
  String? text;
  bool? value;

  DatabaseService({this.text, this.value});

  Future<void> deleteTodo() async {
    await _reference.doc().collection('todos').doc().delete();
  }

  Future<void> updateTodo(bool? value) async {
    Map<String, bool> data = <String, bool>{'isChecked': value!};
    await _reference.doc().collection('todos').doc().update(data);
  }
}

class FirestoreService {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('todos');

  /// The new approcah for fetching data from firestore
  Stream<List<Todo>> streamReadTodo() {
    var todos = _reference.snapshots();
    return todos
        .map((todo) => todo.docs.map((e) => Todo.fromFirestore(e)).toList());
  }

  Future<void> addTodo(Todo todo) async {
    await _reference.add(todo.toJson());
  }
}
