import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';

abstract class TodoRemoteDatasource {
  Future<TodoEntity> addTodoToDatabase({
    required String title,
    required String description,
  });
  Future<List<TodoEntity>> readTodosFromDatabase();
  Future<TodoEntity> updateTodoToDatabase({
    required String title,
    required String description,
  });
  Future<void> deleteTodoToDatabase(String id);
}

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  @override
  Future<TodoEntity> addTodoToDatabase({
    required String title,
    required String description,
  }) {
    // TODO: implement addTodoToDatabase
    throw UnimplementedError();
  }

  @override
  Future<List<TodoEntity>> readTodosFromDatabase() {
    // TODO: implement readTodosFromDatabase
    throw UnimplementedError();
  }

  @override
  Future<TodoEntity> updateTodoToDatabase({
    required String title,
    required String description,
  }) {
    // TODO: implement updateTodoToDatabase
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodoToDatabase(String id) {
    // TODO: implement deleteTodoToDatabase
    throw UnimplementedError();
  }
}
