import 'package:hive/hive.dart';

class HiveDatabase {
  List todoTask = [];
  final _dataBox = Hive.box('dataBox');

  void createData() {
    todoTask = [
      ["Go to the appointment", false],
    ];
  }

  void loadData() {
    todoTask = _dataBox.get('TODOTASK');
  }

  void updateData() {
    _dataBox.put('TODOTASK', todoTask);
  }
}
