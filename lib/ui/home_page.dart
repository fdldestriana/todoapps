import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapps/model/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference todos = firestore.collection("todos");
    Database todo = Database(text: '', value: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
      ),
      body: ListView(children: [
        /// VIEW DATA HERE
        StreamBuilder<QuerySnapshot>(
            stream: todos.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data!.docs
                      .map((QueryDocumentSnapshot document) => Dismissible(
                          key: UniqueKey(),
                          child: Card(
                              elevation: 4,
                              child: CheckboxListTile(
                                  title: Text(document['text']),
                                  value: document['isChecked'],
                                  onChanged: (value) {
                                    setState(() {
                                      todos
                                          .doc(document.id)
                                          .update({'isChecked': value});
                                    });
                                  })),
                          onDismissed: (direction) =>
                              todos.doc(document.id).delete()))
                      .toList(),
                );
              } else {
                return const CircularProgressIndicator();
              }
            })
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text('Add Todos'),
                  content: TextField(
                    onChanged: (String text) {
                      todo.text = text;
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          /// ADD DATA HERE
                          todo.addTodo(todo.text!);
                          todo = Database(text: '');
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
