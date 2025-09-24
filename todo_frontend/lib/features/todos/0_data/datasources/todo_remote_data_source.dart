import 'package:todo_frontend/core/exceptions/exceptions.dart';
import 'package:todo_frontend/features/todos/0_data/models/todo_model.dart';
import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';

abstract class TodoRemoteDatasource {
  Future<List<TodoModel>> readTodosFromDatabase();
  Future<TodoModel> addTodoToDatabase(TodoEntity todo);
  Future<TodoModel> updateTodoToDatabase(TodoEntity todo);
  Future<String> deleteTodoToDatabase(String id);
}

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  TodoRemoteDatasourceImpl();

  @override
  Future<TodoModel> addTodoToDatabase(TodoEntity todo) async {
    String todoId = '';
    try {
      return TodoModel(
        id: todoId,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted,
      );
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<TodoModel>> readTodosFromDatabase() async {
    List<TodoModel> todos = [];
    try {
      return todos;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteTodoToDatabase(String id) async {
    try {
      return id;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> updateTodoToDatabase(TodoEntity todo) async {
    try {
      return TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted,
      );
    } catch (_) {
      throw ServerException();
    }
  }
}
