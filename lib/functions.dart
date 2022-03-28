import 'dart:convert';
import 'package:to_do_app/screen/to_do_screen.dart';
import 'package:to_do_app/tasks.dart';

void editItem(Task item, String headLine, String toDo) {
  item.headLine = headLine;
  item.toDo;
  saveData();
}

void removeItem(Task item) {
  todoList.remove(item);
  saveData();
}

void saveData() {
  List<String> stringList =
      todoList.map((item) => json.encode(item.toMap())).toList();
  prefs.setStringList('todoList', stringList);
}

void addItem(Task item) {
  todoList.add(Task(item.headLine, item.toDo));
  saveData();
}
