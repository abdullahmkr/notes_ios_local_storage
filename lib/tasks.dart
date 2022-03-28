class Task {
  String? headLine = "";
  String? toDo = "";

  Task(this.headLine, this.toDo);

  Task.fromMap(Map map)
      : headLine = map['headLine'],
        toDo = map['toDo'];

  Map toMap() {
    return {'headLine': headLine, 'toDo': toDo};
  }
}
