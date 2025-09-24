import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';

abstract class TodoRepo {
  Future<Either<Failure, TodoEntity>> addTodoToDataSource(TodoEntity todo);
  Future<Either<Failure, List<TodoEntity>>> readTodosFromDataSource();
  Future<Either<Failure, TodoEntity>> updateTodoToDataSource(TodoEntity todo);
  Future<Either<Failure, String>> deleteTodoToDataSource(String id);
}
