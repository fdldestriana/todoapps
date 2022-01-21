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

  Future<void> updateTodo(QueryDocumentSnapshot e) {
    return todo.doc(e.id).update({'isChecked': value});
  }

  Stream<QuerySnapshot<Object?>> getTodo() {
    return todo.snapshots();
  }
}
