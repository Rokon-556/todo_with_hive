import 'package:hive/hive.dart';

class Database {
  List todoList = [];
  final _myBox = Hive.box('mybox');

  void createInitialData() {
     todoList = [
      ['Assignment', false],
      ['Shopping', false],
    ];
  }

  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }
}
