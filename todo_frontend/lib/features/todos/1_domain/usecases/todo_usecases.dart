import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/base_use_case/use_case.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';
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

class AddTodoUC implements UseCase<dynamic, TodoEntity> {
  final TodoRepo todoRepo;

  AddTodoUC({required this.todoRepo});

  @override
  Future<Either<Failure, TodoEntity>> call(TodoEntity todo) async {
    try {
      return await todoRepo.addTodoToDataSource(todo);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

class UpdateTodoUC implements UseCase<dynamic, TodoEntity> {
  final TodoRepo todoRepo;

  UpdateTodoUC({required this.todoRepo});

  @override
  Future<Either<Failure, TodoEntity>> call(TodoEntity params) async {
    try {
      return await todoRepo.updateTodoToDataSource(params);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

class CompleteTodoUC implements UseCase<dynamic, TodoEntity> {
  final TodoRepo todoRepo;

  CompleteTodoUC({required this.todoRepo});

  @override
  Future<Either<Failure, TodoEntity>> call(TodoEntity params) async {
    try {
      return await todoRepo.completeTodoToDataSource(params);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

class DeleteTodoUC implements UseCase<dynamic, String> {
  final TodoRepo todoRepo;

  DeleteTodoUC({required this.todoRepo});

  @override
  Future<Either<Failure, String>> call(String id) async {
    try {
      return await todoRepo.deleteTodoToDataSource(id);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}
