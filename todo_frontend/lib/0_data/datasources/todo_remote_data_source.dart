import 'package:todo_frontend/1_domain/entities/todo_entity.dart';

abstract class TodoRemoteDatasource {
  Future<TodoEntity> addTodoToDatabase(TodoEntity todo);
  Future<List<TodoEntity>> readTodosFromDatabase();
  Future<TodoEntity> updateTodoToDatabase(TodoEntity todo);
  Future<void> deleteTodoToDatabase(String id);
}
