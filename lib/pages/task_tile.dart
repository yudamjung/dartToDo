import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.isCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  final String task;
  final bool isCompleted;
  // 체크박스의 상태가 변경될 때 호출되는 콜백 함수
  // bool? 값을 하나 받는 nullable 함수
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      // Slidable 위젯은 리스트 아이템을 슬라이드하여 추가적인 액션을 제공하는 데 사용
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          dismissible: DismissiblePane(
            onDismissed: () => deleteFunction!(context),
          ), // Bang or Exclamation mark operator는 null이 아님을 보장하는 연산자
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: isCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
                side: BorderSide(color: Colors.black, width: 2),
              ),
              Text(
                task,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  // 할 일이 종료되면 텍스트에 취소선을 적용
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
