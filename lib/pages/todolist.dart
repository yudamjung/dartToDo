import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoapp/pages/task_tile.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: Text("Todo list app"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          TaskTile(
            task: "Make a coffee",
            isCompleted: true,
            onChanged: (p0) {},
          ),
          TaskTile(
            task: "Make a coffee",
            isCompleted: true,
            onChanged: (p0) {},
          ),
          TaskTile(
            task: "Make a coffee",
            isCompleted: true,
            onChanged: (p0) {},
          ),
          TaskTile(
            task: "Make a coffee",
            isCompleted: true,
            onChanged: (p0) {},
          ),
          TaskTile(
            task: "Make a coffee",
            isCompleted: true,
            onChanged: (p0) {},
          ),
        ],
      ),
    );
  }
}
