import 'package:cloud_firestore/cloud_firestore.dart';

// class Todo {
//   String text;
//   bool value;
//   static CollectionReference todo =
//       FirebaseFirestore.instance.collection('todos');

//   Todo({required this.text, required this.value});

//   Future addTodo(String text, bool value) {
//     return todo.add({'todos': text, 'isChecked': value});
//   }

//   Future<void> updateTodo(QueryDocumentSnapshot e) {
//     return todo.doc(e.id).update({'isChecked': value});
//   }

//   Stream<QuerySnapshot<Object?>> getTodo() {
//     return todo.snapshots();
//   }

//   factory Todo.fromJson(Map<String, dynamic> json) {
//     return Todo(text: json['text'], value: json['value']);
//   }

//   Map<String, dynamic> toJson() {
//     return {'text': text, 'value': value};
//   }
// }
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
}
