import 'dart:io';

import 'package:change_case/change_case.dart';
import 'package:postgres/postgres.dart';
import 'package:todo_backend/core/db/db_connection.dart';
import 'package:todo_backend/core/db/db_constants.dart';
import 'package:todo_backend/core/errors/exceptions.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/todos/2_data/datasources/todo_data_source.dart';
import 'package:todo_backend/features/todos/2_data/models/todo_model.dart';

class PostgresTodoDataSource implements TodoDataSource {
  PostgresTodoDataSource({required DbConnection dbConnection})
    : _dbConnection = dbConnection {
    db = _dbConnection.db as Connection;
  }

  final DbConnection _dbConnection;
  late Connection db;

  @override
  Future<TodoModel> createTodo({
    required String title,
    required String description,
    required String userId,
  }) async {
    try {
      final result = await db.execute(
        Sql.named('''
          INSERT INTO ${DbConstants.todosTable}
            (title, description, user_id)
          VALUES
            (@title, @description, @user_id)
          RETURNING *
        '''),
        parameters: {
          'title': title,
          'description': description,
          'user_id': userId,
        },
      );

      if (result.affectedRows != 1) {
        throw const TodoApiException(message: 'Fail to create todo');
      }

      final todoModel = TodoModel.fromJson(result.first.toColumnMap());

      return todoModel;
    } on TodoApiException catch (e) {
      throw TodoApiException(message: e.message, statusCode: e.statusCode);
    } catch (e) {
      throw TodoApiException(message: e.toString());
    }
  }

  @override
  Future<List<TodoModel>> fetchTodos({
    required String userId,
    required MapData match,
    required MapData sort,
  }) async {
    try {
      var sql =
          "SELECT * FROM ${DbConstants.todosTable} WHERE user_id='$userId'";

      if (match['completed'] != null) {
        sql = '$sql AND completed=${match['completed']}';
      }

      if (sort.isNotEmpty) {
        final key = sort.keys.toList()[0].toSnakeCase();
        final value = sort.values.toList()[0];
        sql = '$sql ORDER BY $key $value';
      } else {
        sql = '$sql ORDER BY updated_at DESC';
      }

      if (match['limit'] != null) {
        sql = '$sql LIMIT ${match['limit']}';
      }

      if (match['skip'] != null) {
        sql = '$sql OFFSET ${match['skip']}';
      }

      final result = await db.execute(sql);

      final todoList = result
          .map((todo) => todo.toColumnMap())
          .map(TodoModel.fromJson)
          .toList();

      return todoList;
    } on TodoApiException catch (e) {
      throw TodoApiException(message: e.message, statusCode: e.statusCode);
    } catch (e) {
      throw TodoApiException(message: e.toString());
    }
  }

  @override
  Future<TodoModel> fetchTodo({
    required String todoId,
    required String userId,
  }) async {
    try {
      final result = await db.execute(
        Sql.named('''
          SELECT * FROM ${DbConstants.todosTable}
          WHERE
            id=@id AND user_id=@user_id
        '''),
        parameters: {'id': todoId, 'user_id': userId},
      );

      if (result.isEmpty) {
        throw const TodoApiException(
          message: 'Todo not found',
          statusCode: HttpStatus.notFound,
        );
      }

      final todoModel = TodoModel.fromJson(result.first.toColumnMap());

      return todoModel;
    } on TodoApiException catch (e) {
      throw TodoApiException(message: e.message, statusCode: e.statusCode);
    } catch (e) {
      throw TodoApiException(message: e.toString());
    }
  }

  @override
  Future<TodoModel> toggleTodo({
    required String todoId,
    required String userId,
  }) async {
    try {
      final result = await db.execute(
        Sql.named('''
          UPDATE ${DbConstants.todosTable}
          SET
            completed=NOT completed,
            updated_at=current_timestamp
          WHERE
            id=@id AND user_id=@user_id
          RETURNING *
        '''),
        parameters: {'id': todoId, 'user_id': userId},
      );

      if (result.isEmpty) {
        throw const TodoApiException(
          message: 'Todo not found',
          statusCode: HttpStatus.notFound,
        );
      }

      final todoModel = TodoModel.fromJson(result.first.toColumnMap());

      return todoModel;
    } on TodoApiException catch (e) {
      throw TodoApiException(message: e.message, statusCode: e.statusCode);
    } catch (e) {
      throw TodoApiException(message: e.toString());
    }
  }

  @override
  Future<TodoModel> updateTodo({
    required String todoId,
    required String title,
    required String description,
    required String userId,
  }) async {
    try {
      final result = await db.execute(
        Sql.named('''
          UPDATE ${DbConstants.todosTable}
          SET
            title=@title,
            description=@description,
            updated_at=current_timestamp
          WHERE
            id=@id AND user_id=@user_id
          RETURNING *
        '''),
        parameters: {
          'id': todoId,
          'user_id': userId,
          'title': title,
          'description': description,
        },
      );

      if (result.isEmpty) {
        throw const TodoApiException(
          message: 'Todo not found',
          statusCode: HttpStatus.notFound,
        );
      }

      final todoModel = TodoModel.fromJson(result.first.toColumnMap());

      return todoModel;
    } on TodoApiException catch (e) {
      throw TodoApiException(message: e.message, statusCode: e.statusCode);
    } catch (e) {
      throw TodoApiException(message: e.toString());
    }
  }

  @override
  Future<void> deleteTodo({
    required String todoId,
    required String userId,
  }) async {
    try {
      final result = await db.execute(
        Sql.named('''
          DELETE FROM ${DbConstants.todosTable}
          WHERE
            id=@id AND user_id=@user_id
          RETURNING *
        '''),
        parameters: {'id': todoId, 'user_id': userId},
      );

      if (result.isEmpty) {
        throw const TodoApiException(
          message: 'Todo not found',
          statusCode: HttpStatus.notFound,
        );
      }
    } on TodoApiException catch (e) {
      throw TodoApiException(message: e.message, statusCode: e.statusCode);
    } catch (e) {
      throw TodoApiException(message: e.toString());
    }
  }
}
