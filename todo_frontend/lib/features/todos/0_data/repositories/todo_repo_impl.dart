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
  Future<Either<Failure, TodoEntity>> addTodoToDataSource({
    required String title,
    required String description,
  }) async {
    try {
      final result = await todoRemoteDatasource.addTodoToDatabase(
        title: title,
        description: description,
      );
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
  Future<Either<Failure, TodoEntity>> updateTodoToDataSource({
    required String title,
    required String description,
  }) async {
    try {
      final result = await todoRemoteDatasource.updateTodoToDatabase(
        title: title,
        description: description,
      );
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  //!TODO

  // @override
  // Future<Either<Failure, TodoEntity>> deleteTodoToDataSource({
  //   required String id,
  // }) async {
  //   try {
  //     await todoRemoteDatasource.deleteTodoToDatabase(id);
  //     return right(id);
  //   } on ServerException catch (_) {
  //     return left(ServerFailure());
  //   } catch (_) {
  //     return left(GeneralFailure());
  //   }
  // }
}
