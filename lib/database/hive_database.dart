import 'package:hive/hive.dart';

class HiveDatabase {
  List todoTask = [];
  final _dataBox = Hive.box('dataBox');

  void createData() {
    todoTask = [
      ["Go to the appointment", false, DateTime.now()],
    ];
  }

  void loadData() {
    todoTask = _dataBox.get('TODOTASK');

    for (int i = 0; i < todoTask.length; i++) {
      if (todoTask[i].length < 3) {
        todoTask[i].add(DateTime.now());
      }
    }
  }

  void updateData() {
    _dataBox.put('TODOTASK', todoTask);
  }
}
