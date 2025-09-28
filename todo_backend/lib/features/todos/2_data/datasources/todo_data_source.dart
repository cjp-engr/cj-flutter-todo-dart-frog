import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/todos/2_data/models/todo_model.dart';

abstract interface class TodoDataSource {
  Future<TodoModel> createTodo({
    required String title,
    required String description,
    required String userId,
  });

  Future<List<TodoModel>> fetchTodos({
    required String userId,
    required MapData match,
    required MapData sort,
  });

  Future<TodoModel> fetchTodo({required String todoId, required String userId});

  Future<TodoModel> toggleTodo({
    required String todoId,
    required String userId,
  });

  Future<TodoModel> updateTodo({
    required String todoId,
    required String title,
    required String description,
    required String userId,
  });

  Future<void> deleteTodo({required String todoId, required String userId});
}
