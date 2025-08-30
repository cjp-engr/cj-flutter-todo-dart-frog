import 'package:dartz/dartz.dart';
import 'package:todo_frontend/1_domain/entities/todo_entity.dart';
import 'package:todo_frontend/1_domain/failures/failures.dart';

abstract class TodoRepo {
  Future<Either<Failure, TodoEntity>> addTodoToDataSource(TodoEntity todo);
  Future<Either<Failure, List<TodoEntity>>> readTodosFromDataSource();
  Future<Either<Failure, TodoEntity>> updateTodoToDataSource(TodoEntity todo);
  Future<Either<Failure, String>> deleteTodoToDataSource(String id);
}
