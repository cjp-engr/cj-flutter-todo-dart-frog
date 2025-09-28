import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/request/create_todo_request_model.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/response/todo_response_model.dart';
import 'package:todo_backend/features/todos/1_domain/presenters/todo_presenter.dart';
import 'package:todo_backend/features/todos/1_domain/repositories/todo_repository.dart';

class CreateTodoUsecase
    implements Usecase<TodoResponseModel, CreateTodoRequestModel> {
  CreateTodoUsecase({
    required TodoRepository todoRepository,
    required TodoPresenter todoPresenter,
  }) : _todoRepository = todoRepository,
       _todoPresenter = todoPresenter;

  final TodoRepository _todoRepository;
  final TodoPresenter _todoPresenter;

  @override
  FutureEither<TodoResponseModel> call(CreateTodoRequestModel params) async {
    final result = await _todoRepository.createTodo(
      description: params.description,
      userId: params.userId,
      title: params.title,
    );

    final response = _todoPresenter.createTodoPresenter(result);

    return response;
  }
}
