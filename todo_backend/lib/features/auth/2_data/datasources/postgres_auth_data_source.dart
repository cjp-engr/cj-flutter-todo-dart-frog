import 'dart:io';

import 'package:postgres/postgres.dart';
import 'package:todo_backend/core/db/db_connection.dart';
import 'package:todo_backend/core/db/db_constants.dart';
import 'package:todo_backend/core/errors/exceptions.dart';
import 'package:todo_backend/core/models/user_model.dart';
import 'package:todo_backend/core/services/password_manager.dart';
import 'package:todo_backend/features/auth/data/datasources/auth_data_source.dart';

class PostgresAuthDataSource implements AuthDataSource {
  PostgresAuthDataSource({
    required DbConnection dbConnection,
    required PasswordManager passwordManager,
  }) : _dbConnection = dbConnection,
       _passwordManager = passwordManager {
    db = _dbConnection.db as Connection;
  }

  final DbConnection _dbConnection;
  final PasswordManager _passwordManager;
  late Connection db;

  @override
  Future<UserModel> signup({
    required String username,
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      final foundUser = await db.execute(
        Sql.named('''
          SELECT * FROM ${DbConstants.usersTable}
          WHERE email=@email
        '''),
        parameters: {'email': email},
      );

      if (foundUser.isNotEmpty) {
        throw const TodoApiException(
          message: 'Email already taken',
          statusCode: HttpStatus.badRequest,
        );
      }

      final hashedPassword = _passwordManager.encryptPassword(password);

      final result = await db.execute(
        Sql.named('''
          INSERT INTO ${DbConstants.usersTable}
            (username, email, fullname, password)
          VALUES
            (@username, @email, @fullname, @password)
          RETURNING *
        '''),
        parameters: {
          'username': username,
          'email': email,
          'fullname': fullname,
          'password': hashedPassword,
        },
      );

      if (result.affectedRows != 1) {
        throw const TodoApiException(message: 'Failed to create a user');
      }

      final userModel = UserModel.fromJson(result.first.toColumnMap());

      return userModel;
    } on TodoApiException catch (e) {
      throw TodoApiException(message: e.message, statusCode: e.statusCode);
    } catch (e) {
      throw TodoApiException(message: e.toString());
    }
  }
}
