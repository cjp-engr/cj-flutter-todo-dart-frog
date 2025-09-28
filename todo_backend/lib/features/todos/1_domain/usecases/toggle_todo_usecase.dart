import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/request/toggle_todo_request_model.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/response/todo_response_model.dart';
import 'package:todo_backend/features/todos/1_domain/presenters/todo_presenter.dart';
import 'package:todo_backend/features/todos/1_domain/repositories/todo_repository.dart';

class ToggleTodoUsecase
    implements Usecase<TodoResponseModel, ToggleTodoRequestModel> {
  ToggleTodoUsecase({
    required TodoRepository todoRepository,
    required TodoPresenter todoPresenter,
  }) : _todoRepository = todoRepository,
       _todoPresenter = todoPresenter;

  final TodoRepository _todoRepository;
  final TodoPresenter _todoPresenter;

  @override
  FutureEither<TodoResponseModel> call(ToggleTodoRequestModel params) async {
    final result = await _todoRepository.toggleTodo(
      todoId: params.todoId,
      userId: params.userId,
    );

    final response = _todoPresenter.toggleTodoPresenter(result);

    return response;
  }
}
