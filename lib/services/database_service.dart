import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapps/model/todo.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _reference = _firestore.collection('todos');

class DatabaseService with ChangeNotifier {
  String? text;
  bool? value;

  DatabaseService({this.text, this.value});

  Future<void> addTodo(String text, {bool value = false}) async {
    Map<String, dynamic> data = <String, dynamic>{
      'text': text,
      'isChecked': value
    };
    await _reference.add(data);
  }

  Stream<QuerySnapshot> readTodo() {
    var todo = _reference.snapshots();
    return todo;
  }

  /// The new approcah for fetching data from firestore
  Stream<dynamic> streamReadTodo() {
    var todos = _reference.snapshots();
    return todos
        .map((todo) => todo.docs.map((e) => Todo.fromFirestore(e)).toList());
  }

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

  Future<void> addTodo(Todo todo) async {
    await _reference.add(todo.toJson());
  }
}
