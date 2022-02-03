import 'package:flutter/material.dart';
import 'package:todoapps/ui/widgets/custom_floating_action_button.dart';
import 'package:todoapps/ui/widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          'My Todos',
          style: TextStyle(color: Colors.black),
        )),
      ),
      body: ListView(children: const [
        TodoList(),
      ]),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
