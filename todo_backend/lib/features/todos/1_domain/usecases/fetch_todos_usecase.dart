import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/request/fetch_todos_request_model.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/response/todo_response_model.dart';
import 'package:todo_backend/features/todos/1_domain/presenters/todo_presenter.dart';
import 'package:todo_backend/features/todos/1_domain/repositories/todo_repository.dart';

class FetchTodosUsecase
    implements Usecase<List<TodoResponseModel>, FetchTodosRequestModel> {
  FetchTodosUsecase({
    required TodoRepository todoRepository,
    required TodoPresenter todoPresenter,
  }) : _todoRepository = todoRepository,
       _todoPresenter = todoPresenter;

  final TodoRepository _todoRepository;
  final TodoPresenter _todoPresenter;

  @override
  FutureEither<List<TodoResponseModel>> call(
    FetchTodosRequestModel params,
  ) async {
    final result = await _todoRepository.fetchTodos(
      userId: params.userId,
      match: params.match,
      sort: params.sort,
    );

    final response = _todoPresenter.fetchTodosPresenter(result);

    return response;
  }
}
