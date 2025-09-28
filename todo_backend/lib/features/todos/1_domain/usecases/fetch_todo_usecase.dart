import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/request/fetch_todo_request_model.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/response/todo_response_model.dart';
import 'package:todo_backend/features/todos/1_domain/presenters/todo_presenter.dart';
import 'package:todo_backend/features/todos/1_domain/repositories/todo_repository.dart';

class FetchTodoUsecase
    implements Usecase<TodoResponseModel, FetchTodoRequestModel> {
  FetchTodoUsecase({
    required TodoRepository todoRepository,
    required TodoPresenter todoPresenter,
  }) : _todoRepository = todoRepository,
       _todoPresenter = todoPresenter;

  final TodoRepository _todoRepository;
  final TodoPresenter _todoPresenter;

  @override
  FutureEither<TodoResponseModel> call(FetchTodoRequestModel params) async {
    final result = await _todoRepository.fetchTodo(
      todoId: params.todoId,
      userId: params.userId,
    );

    final response = _todoPresenter.fetchTodoPresenter(result);

    return response;
  }
}
