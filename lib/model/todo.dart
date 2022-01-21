import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String text;
  bool value;
  static CollectionReference todo =
      FirebaseFirestore.instance.collection('todos');

  Todo({required this.text, required this.value});

  Future addTodo(String text, bool value) {
    return todo.add({'todos': text, 'isChecked': value});
  }

  Stream<QuerySnapshot<Object?>> getData() {
    return todo.snapshots();
  }

  doc(String id) {}
}
