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
  CheckboxState input = CheckboxState(text: '');
  final checkboxes = [
    CheckboxState(text: 'Buy groceries'),
    CheckboxState(text: 'Going lunch'),
    CheckboxState(text: 'Meet Adam Warlock'),
    CheckboxState(text: 'Adding checkout fiture'),
    CheckboxState(text: 'Brainstorming Solidity'),
  ];

  Widget buildSingleCheckBox(CheckboxState checkbox) {
    return CheckboxListTile(
        title: Text(checkbox.text),
        value: checkbox.value,
        onChanged: (value) {
          setState(() {
            checkbox.value = value!;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference todos = firestore.collection("todos");
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
      ),
      body: ListView.builder(
          itemCount: checkboxes.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              child: Card(
                  elevation: 4, child: buildSingleCheckBox(checkboxes[index])),
              onDismissed: (direction) => checkboxes.removeAt(index),
            );
          }),
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
                          setState(() {
                            checkboxes.add(input);
                            todos.add({"todos": input.text});
                          });

                          input = CheckboxState(text: '');
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
