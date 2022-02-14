import 'package:flutter/material.dart';
import 'package:todoapps/ui/widgets/custom_floating_action_button.dart';
import 'package:todoapps/ui/widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  String title;
  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text(
          'Tasks',
          style: TextStyle(color: Color(0xFFB39DDB)),
        ),
      ),
      body: ListView(
        children: const [TodoList()],
      ),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
