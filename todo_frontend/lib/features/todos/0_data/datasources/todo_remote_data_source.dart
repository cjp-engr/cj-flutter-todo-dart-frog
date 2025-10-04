import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_frontend/core/exceptions/exceptions.dart';
import 'package:todo_frontend/core/storage/secure_storage.dart';
import 'package:todo_frontend/features/todos/0_data/models/todo_model.dart';
import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';
import 'package:http/http.dart' as http;

abstract class TodoRemoteDatasource {
  Future<List<TodoModel>> readTodosFromDatabase();
  Future<TodoModel> addTodoToDatabase(TodoEntity todo);
  Future<TodoModel> updateTodoToDatabase(TodoEntity todo);
  Future<String> deleteTodoToDatabase(String id);
}

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  final FlutterSecureStorage secureStorage;
  TodoRemoteDatasourceImpl({required this.secureStorage});
  final String baseUrl = dotenv.env['URL'] ?? 'default_url';

  @override
  Future<TodoModel> addTodoToDatabase(TodoEntity todo) async {
    final token = await secureStorage.read(key: SecureStorageKeys.accessToken);
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}todos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'title': todo.title,
          'description': todo.description,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return TodoModel.fromJson(data['todo']);
      } else {
        throw Exception('Failed to register user');
      }
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<TodoModel>> readTodosFromDatabase() async {
    final token = await secureStorage.read(key: SecureStorageKeys.accessToken);
    List<TodoModel> todos = [];

    try {
      final response = await http.get(
        Uri.parse('${baseUrl}todos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        for (var todo in data['todos']) {
          todos.add(TodoModel.fromJson(todo));
        }
        return todos;
      } else {
        throw Exception('Failed to register user');
      }
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteTodoToDatabase(String id) async {
    final token = await secureStorage.read(key: SecureStorageKeys.accessToken);

    try {
      await http.delete(
        Uri.parse('${baseUrl}todos/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // if (response.statusCode == 204) {

      // } else {
      //   throw Exception('Failed to register user');
      // }
      return id;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> updateTodoToDatabase(TodoEntity todo) async {
    final token = await secureStorage.read(key: SecureStorageKeys.accessToken);
    try {
      final response = await http.put(
        Uri.parse('${baseUrl}todos/${todo.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'title': todo.title,
          'description': todo.description,
        }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return TodoModel.fromJson(data['todo']);
      } else {
        throw Exception('Failed to register user');
      }
    } catch (_) {
      throw ServerException();
    }
  }
}
