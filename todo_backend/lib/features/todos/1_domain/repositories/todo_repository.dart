import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/todos/1_domain/entities/todo_entity.dart';

abstract interface class TodoRepository {
  FutureEither<Todo> createTodo({
    required String title,
    required String description,
    required String userId,
  });

  FutureEither<List<Todo>> fetchTodos({
    required String userId,
    required MapData match,
    required MapData sort,
  });

  FutureEither<Todo> fetchTodo({
    required String todoId,
    required String userId,
  });

  FutureEither<Todo> toggleTodo({
    required String todoId,
    required String userId,
  });

  FutureEither<Todo> updateTodo({
    required String todoId,
    required String title,
    required String description,
    required String userId,
  });

  FutureEither<void> deleteTodo({
    required String todoId,
    required String userId,
  });
}
