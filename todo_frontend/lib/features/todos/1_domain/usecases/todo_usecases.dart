import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/base_use_case/use_case.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/todos/1_domain/dtos/request/todos_request_model.dart';
import 'package:todo_frontend/features/todos/1_domain/dtos/response/todos_response_model.dart';
import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';
import 'package:todo_frontend/features/todos/1_domain/presenters/todos_presenter.dart';
import 'package:todo_frontend/features/todos/1_domain/repositories/todo_repo.dart';

class ReadTodosUC implements UseCaseNoParams {
  final TodoRepo todoRepo;

  ReadTodosUC({required this.todoRepo});

  @override
  Future<Either<Failure, List<TodoEntity>>> call() async {
    try {
      return await todoRepo.readTodosFromDataSource();
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

class AddTodoUC implements UseCase<TodosResponseModel, TodosRequestModel> {
  final TodoRepo todoRepo;
  final TodosPresenter presenter;

  AddTodoUC({required this.todoRepo, required this.presenter});

  @override
  Future<Either<Failure, TodosResponseModel>> call(
    TodosRequestModel todo,
  ) async {
    try {
      //! TODO
      final result = await todoRepo.addTodoToDataSource(
        title: '',
        description: '',
      );
      return presenter.todosPresenter(result);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

class UpdateTodoUC implements UseCase<TodosResponseModel, TodosRequestModel> {
  final TodoRepo todoRepo;
  final TodosPresenter presenter;

  UpdateTodoUC({required this.todoRepo, required this.presenter});

  @override
  Future<Either<Failure, TodosResponseModel>> call(
    TodosRequestModel todo,
  ) async {
    try {
      //! TODO
      final result = await todoRepo.updateTodoToDataSource(
        title: '',
        description: '',
      );
      return presenter.todosPresenter(result);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

//! TODO
// class DeleteTodoUC implements UseCase<TodosResponseModel, TodosRequestModel> {
//   final TodoRepo todoRepo;
//   final TodosPresenter presenter;

//   DeleteTodoUC({required this.todoRepo, required this.presenter});

//   @override
//   Future<Either<Failure, TodosResponseModel>> call(TodosRequestModel id) async {
//     try {
//       final result = await todoRepo.deleteTodoToDataSource(id: '');
//       return presenter.todosPresenter(result);
//     } catch (e) {
//       return Left(GeneralFailure());
//     }
//   }
// }
