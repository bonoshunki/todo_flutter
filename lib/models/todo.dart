import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'todo.g.dart';

@JsonSerializable(nullable: false)
class Todo {
  int id;
  final String todo;
  bool achieved = false;

  Todo({required this.id, required this.todo, required this.achieved});

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
  @override
  String toString() => json.encode(toJson());

  Map<String, dynamic> toMap() {
    //0 = false, 1 = true
    int achievedInt = achieved ? 1 : 0;
    return {'id': id, 'todo': todo, 'achieved': achievedInt};
  }
}

