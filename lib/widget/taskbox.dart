import 'package:flutter/material.dart';

class TaskBox extends StatelessWidget {
  const TaskBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // fromARGB -> a: alpha (투명도), r: red, g: green, b: blue
      backgroundColor: Color.fromARGB(255, 236, 230, 240),
      content: SizedBox(height: 380),
    );
  }
}
