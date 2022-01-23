import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _reference = _firestore.collection('todos');

class Database {
  String? text;
  bool? value;

  Database({this.text, this.value});

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

  Future<void> deleteTodo() async {
    await _reference.doc().collection('todos').doc().delete();
  }

  Future<void> updateTodo(bool? value) async {
    Map<String, bool> data = <String, bool>{'isChecked': value!};
    await _reference.doc().collection('todos').doc().update(data);
  }
}
