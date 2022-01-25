import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String? text;
  bool? value;

  Todo({this.text, this.value});

  factory Todo.fromFirestore(QueryDocumentSnapshot doc) {
    return Todo(text: doc['text'] ?? '', value: doc['isChecked'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'isChecked': value};
  }
}
