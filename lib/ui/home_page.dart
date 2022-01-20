import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapps/model/checkbox_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CheckboxState input = CheckboxState(
    text: '',
    value: false,
  );

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference todos = firestore.collection("todos");
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
      ),
      body: ListView(children: [
        /// VIEW DATA HERE
        /// First attempt to fecth data from firestore, once
        // FutureBuilder<QuerySnapshot>(
        //     future: todos.get(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return Column(
        //           children: snapshot.data!.docs
        //               .map((e) => Dismissible(
        //                   key: UniqueKey(),
        //                   child: Card(
        //                       elevation: 4,
        //                       child: CheckboxListTile(
        //                           title: Text(e.get('todos')),
        //                           value: e.get('isChecked'),
        //                           onChanged: (value) {
        //                             value = e.get('isChecked');
        //                           })),
        //                   // ignore: avoid_returning_null_for_void
        //                   onDismissed: (direction) => null))
        //               .toList(),
        //         );
        //       } else {
        //         return const Text('Loading data');
        //       }
        //     })

        /// Second attempt to fecth data from firestore, streamingly
        StreamBuilder<QuerySnapshot>(
            stream: todos.snapshots(),
            builder: (context, snapshot) {
              return Column(
                children: snapshot.data!.docs
                    .map((e) => Dismissible(
                        key: UniqueKey(),
                        child: Card(
                            elevation: 4,
                            child: CheckboxListTile(
                                title: Text(e.get('todos')),
                                value: e.get('isChecked'),
                                onChanged: (value) {
                                  setState(() {
                                    // value = !value!;
                                    todos
                                        .doc(e.id)
                                        .update({'isChecked': value});
                                  });
                                })),
                        onDismissed: (direction) => todos.doc(e.id).delete()))
                    .toList(),
              );
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
                    onChanged: (String value) {
                      input.text = value;
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          /// ADD DATA HERE
                          todos.add(
                              {'todos': input.text, 'isChecked': input.value});
                          input = CheckboxState(text: '', value: false);
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
