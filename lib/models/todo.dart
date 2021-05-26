class Todo {
  final int id;
  final String todo;
  bool achieved = false;

  Todo({required this.id, required this.todo, required this.achieved});

  Map<String, dynamic> toMap() {
    //0 = false, 1 = true
    int achievedInt = achieved ? 1 : 0;
    return {
      'id':id,
      'todo':todo,
      'achieved':achievedInt
    };
  }
}