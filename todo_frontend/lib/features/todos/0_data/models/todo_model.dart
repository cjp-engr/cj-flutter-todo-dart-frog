import 'package:equatable/equatable.dart';
import 'package:todo_frontend/core/typedefs/typedefs.dart';
import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity with EquatableMixin {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
  });

  factory TodoModel.fromJson(MapData json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed'],
    );
  }
}
