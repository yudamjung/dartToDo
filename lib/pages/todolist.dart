import 'package:flutter/material.dart';
import 'package:todoapp/pages/task_tile.dart';
import 'package:todoapp/widget/taskbox.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _controller = TextEditingController();

  // 할 일 목록을 저장하는 리스트
  List todoTask = [
    ["Meet my friend", false],
    ["Make a dinner", false],
  ];

  // 체크박스가 눌리면 해당 인덱스의 완료 여부를 토글하는 함수
  void checkBoxTapped(int index) {
    setState(() {
      // Toggle the completion status of the task at the given index
      todoTask[index][1] = !todoTask[index][1];
    });
  }

  // 새로운 할 일을 추가하는 함수
  void saveTask() {
    setState(() {
      todoTask.add([_controller.text, false]);
      _controller.clear(); // 텍스트 필드를 초기화하여 다음 입력을 준비
      Navigator.pop(context);
    });
  }

  // FAB를 클릭해 새로운 할 일을 추가하는 다이얼로그를 표시하는 함수
  void addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return TaskBox(
          controller: _controller,
          onSave: saveTask,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  // todoTask 리스트에서 해당 인덱스의 할 일을 삭제하는 함수
  // key를 미사용하며 index를 직접 받아 삭제하는 방식으로 구현 -> 삭제 애니메이션 중 리스트 변경 발생으로 인한 에러 발생
  void deleteTask(int index) {
    setState(() {
      todoTask.removeAt(index);
    });
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
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),

      // Add a floating action button to add new tasks
      floatingActionButton: FloatingActionButton(
        onPressed: addNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
