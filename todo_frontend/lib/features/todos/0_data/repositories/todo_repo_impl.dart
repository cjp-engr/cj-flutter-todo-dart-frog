import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/exceptions/exceptions.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/todos/0_data/datasources/todo_remote_data_source.dart';
import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';
import 'package:todo_frontend/features/todos/1_domain/repositories/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  final TodoRemoteDatasource todoRemoteDatasource;

  TodoRepoImpl({required this.todoRemoteDatasource});
  @override
  Future<Either<Failure, TodoEntity>> addTodoToDataSource(
    TodoEntity todo,
  ) async {
    try {
      final result = await todoRemoteDatasource.addTodoToDatabase(todo);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> readTodosFromDataSource() async {
    try {
      final result = await todoRemoteDatasource.readTodosFromDatabase();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteTodoToDataSource(String id) async {
    try {
      await todoRemoteDatasource.deleteTodoToDatabase(id);
      return right(id);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, TodoEntity>> updateTodoToDataSource(
    TodoEntity todo,
  ) async {
    try {
      final result = await todoRemoteDatasource.updateTodoToDatabase(todo);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, TodoEntity>> completeTodoToDataSource(
    TodoEntity todo,
  ) async {
    try {
      final result = await todoRemoteDatasource.completeTodoToDatabase(todo);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }
}
