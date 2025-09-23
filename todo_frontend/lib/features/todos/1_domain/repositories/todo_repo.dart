import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';

abstract class TodoRepo {
  Future<Either<Failure, TodoEntity>> addTodoToDataSource({
    required String title,
    required String description,
  });
  Future<Either<Failure, List<TodoEntity>>> readTodosFromDataSource();
  Future<Either<Failure, TodoEntity>> updateTodoToDataSource({
    required String title,
    required String description,
  });
  //! TODO
  // Future<Either<Failure, String>> deleteTodoToDataSource({required String id});
}
