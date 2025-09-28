import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/response/todo_response_model.dart';
import 'package:todo_backend/features/todos/1_domain/entities/todo_entity.dart';
import 'package:todo_backend/features/todos/1_domain/presenters/todo_presenter.dart';

class TodoPresenterImpl implements TodoPresenter {
  TodoResponseModel _convertTodoEntityToTodoResponse(Todo todo) {
    return TodoResponseModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      completed: todo.completed,
      userId: todo.userId,
      createdAt: DateFormat(
        'E,MMM dd,yyyy - HH:mm:ss a',
      ).format(todo.createdAt),
      updatedAt: DateFormat(
        'E,MMM dd,yyyy - HH:mm:ss a',
      ).format(todo.updatedAt),
    );
  }

  @override
  EitherOr<TodoResponseModel> createTodoPresenter(EitherOr<Todo> result) {
    final EitherOr<TodoResponseModel> response = result.match(
      Left.new,
      (todo) => Right(_convertTodoEntityToTodoResponse(todo)),
    );

    return response;
  }

  @override
  EitherOr<List<TodoResponseModel>> fetchTodosPresenter(
    EitherOr<List<Todo>> result,
  ) {
    final EitherOr<List<TodoResponseModel>> response = result.match(Left.new, (
      todos,
    ) {
      final todosResponse = [
        for (final todo in todos) _convertTodoEntityToTodoResponse(todo),
      ];

      return Right(todosResponse);
    });

    return response;
  }

  @override
  EitherOr<TodoResponseModel> fetchTodoPresenter(EitherOr<Todo> result) {
    final EitherOr<TodoResponseModel> response = result.match(
      Left.new,
      (todo) => Right(_convertTodoEntityToTodoResponse(todo)),
    );

    return response;
  }

  @override
  EitherOr<TodoResponseModel> toggleTodoPresenter(EitherOr<Todo> result) {
    final EitherOr<TodoResponseModel> response = result.match(
      Left.new,
      (todo) => Right(_convertTodoEntityToTodoResponse(todo)),
    );

    return response;
  }

  @override
  EitherOr<TodoResponseModel> updateTodoPresenter(EitherOr<Todo> result) {
    final EitherOr<TodoResponseModel> response = result.match(
      Left.new,
      (todo) => Right(_convertTodoEntityToTodoResponse(todo)),
    );

    return response;
  }
}
