import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/database/hive_database.dart';
import 'package:todoapp/pages/task_tile.dart';
import 'package:todoapp/widget/taskbox.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  HiveDatabase db = HiveDatabase();
  final _dataBox = Hive.box('dataBox');
  final _controller = TextEditingController();

  @override
  void initState() {
    if (_dataBox.get('TODOTASK') == null) {
      db.createData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // 체크박스가 눌리면 해당 인덱스의 완료 여부를 토글하는 함수
  void checkBoxTapped(int index) {
    setState(() {
      // Toggle the completion status of the task at the given index
      db.todoTask[index][1] = !db.todoTask[index][1];
    });
    db.updateData(); // 데이터베이스에 변경 사항을 저장
  }

  // // 새로운 할 일을 추가하는 함수
  // void saveTask() {
  //   setState(() {
  //     db.todoTask.add([_controller.text, false]);
  //     _controller.clear(); // 텍스트 필드를 초기화하여 다음 입력을 준비
  //     Navigator.pop(context);
  //   });
  //   db.updateData(); // 데이터베이스에 변경 사항을 저장
  // }

  // FAB를 클릭해 새로운 할 일을 추가하는  다이얼로그를 표시하는 함수
  void addNewTask() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return TaskBox(
          controller: _controller,
          onCancel: () => Navigator.pop(context),
        );
      },
    );

    if (result != null) {
      setState(() {
        db.todoTask.add([result['task'], false, result['dateTime']]);
      });
      db.updateData();
    }
  }

  // todoTask 리스트에서 해당 인덱스의 할 일을 삭제하는 함수
  // key를 미사용하며 index를 직접 받아 삭제하는 방식으로 구현 -> 삭제 애니메이션 중 리스트 변경 발생으로 인한 에러 발생
  void deleteTask(int index) {
    setState(() {
      db.todoTask.removeAt(index);
    });
    db.updateData();
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
        itemCount: db.todoTask.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: db.todoTask[index][0],
            isCompleted: db.todoTask[index][1],
            taskTime: db.todoTask[index][2],
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
