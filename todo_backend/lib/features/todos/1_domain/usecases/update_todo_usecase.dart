import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/request/update_todo_request_model.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/response/todo_response_model.dart';
import 'package:todo_backend/features/todos/1_domain/presenters/todo_presenter.dart';
import 'package:todo_backend/features/todos/1_domain/repositories/todo_repository.dart';

class UpdateTodoUsecase
    implements Usecase<TodoResponseModel, UpdateTodoRequestModel> {
  UpdateTodoUsecase({
    required TodoRepository todoRepository,
    required TodoPresenter todoPresenter,
  }) : _todoRepository = todoRepository,
       _todoPresenter = todoPresenter;

  final TodoRepository _todoRepository;
  final TodoPresenter _todoPresenter;

  @override
  FutureEither<TodoResponseModel> call(UpdateTodoRequestModel params) async {
    final result = await _todoRepository.updateTodo(
      todoId: params.todoId,
      title: params.title,
      description: params.description,
      userId: params.userId,
    );

    final response = _todoPresenter.updateTodoPresenter(result);

    return response;
  }
}
