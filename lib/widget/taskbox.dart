import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/widget/mybutton.dart';

class TaskBox extends StatelessWidget {
  const TaskBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });
  // TextEditingController는 TextField의 텍스트를 제어(값 읽기,수정 등)하는 데 사용되는 클래스
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // fromARGB -> a: alpha (투명도), r: red, g: green, b: blue
      backgroundColor: Color.fromARGB(255, 236, 230, 240),
      content: SizedBox(
        height: 380,
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple, width: 2),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // code refactoring!
                MyButton(onPressed: onSave, buttonName: "Save"),
                SizedBox(width: 20),
                MyButton(onPressed: onCancel, buttonName: "Cancel"),
              ],
            ),
            Lottie.asset("lottie/Checklist.json", width: 150, height: 150),
          ],
        ),
      ),
    );
  }
}
