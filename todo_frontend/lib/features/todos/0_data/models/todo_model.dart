import 'package:equatable/equatable.dart';
import 'package:todo_frontend/core/typedefs/typedefs.dart';
import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity with EquatableMixin {
  final String userId;
  final String createdAt;
  final String updatedAt;
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TodoModel.fromJson(MapData json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['completed'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
