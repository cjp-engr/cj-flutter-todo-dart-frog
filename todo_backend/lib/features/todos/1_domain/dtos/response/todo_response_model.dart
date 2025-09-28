import 'package:equatable/equatable.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';

class TodoResponseModel extends Equatable {
  const TodoResponseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String description;
  final bool completed;
  final String userId;
  final String createdAt;
  final String updatedAt;

  @override
  List<Object> get props {
    return [id, title, description, completed, userId, createdAt, updatedAt];
  }

  MapData toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    return 'TodoResponseModel(id: $id, title: $title, description: $description, '
        'completed: $completed, userId: $userId, '
        'createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
