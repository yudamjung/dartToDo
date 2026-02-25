import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'pages/todolist.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('dataBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TodoList());
  }
}
