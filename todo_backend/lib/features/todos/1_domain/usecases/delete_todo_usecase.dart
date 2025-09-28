import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/todos/1_domain/dtos/request/delete_todo_request_model.dart';
import 'package:todo_backend/features/todos/1_domain/repositories/todo_repository.dart';

class DeleteTodoUsecase implements Usecase<void, DeleteTodoRequestModel> {
  DeleteTodoUsecase({required TodoRepository todoRepository})
    : _todoRepository = todoRepository;

  final TodoRepository _todoRepository;

  @override
  FutureEither<void> call(DeleteTodoRequestModel params) async {
    final result = await _todoRepository.deleteTodo(
      todoId: params.todoId,
      userId: params.userId,
    );

    return result;
  }
}
