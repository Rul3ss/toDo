import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/constants/database_constants.dart';

class ToDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box(BOXNAME);

  void createInitialData() {
    toDoList = [
      [DEFAULT_TASK, false],
    ];
  }

  void loadData() {
    toDoList = _myBox.get(LISTNAME);
  }

  void updateDataBase() {
    _myBox.put(LISTNAME, toDoList);
  }
}
