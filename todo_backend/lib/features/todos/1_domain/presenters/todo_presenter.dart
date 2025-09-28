import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/response/todo_response_model.dart';
import 'package:todo_backend/features/todos/1_domain/entities/todo_entity.dart';

abstract interface class TodoPresenter {
  EitherOr<TodoResponseModel> createTodoPresenter(EitherOr<Todo> result);

  EitherOr<List<TodoResponseModel>> fetchTodosPresenter(
    EitherOr<List<Todo>> result,
  );

  EitherOr<TodoResponseModel> fetchTodoPresenter(EitherOr<Todo> result);

  EitherOr<TodoResponseModel> toggleTodoPresenter(EitherOr<Todo> result);

  EitherOr<TodoResponseModel> updateTodoPresenter(EitherOr<Todo> result);
}
