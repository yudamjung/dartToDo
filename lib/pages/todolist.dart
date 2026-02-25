import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoapp/pages/task_tile.dart';
import 'package:todoapp/widget/taskbox.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List todoTask = [
    ["Meet my friend", false],
    ["Make a dinner", false],
  ];

  void checkBoxTapped(int index) {
    setState(() {
      // Toggle the completion status of the task at the given index
      todoTask[index][1] = !todoTask[index][1];
    });
  }

  void addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return TaskBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: Text("Todo list app"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        itemCount: todoTask.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: todoTask[index][0],
            isCompleted: todoTask[index][1],
            onChanged: (value) => checkBoxTapped(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
