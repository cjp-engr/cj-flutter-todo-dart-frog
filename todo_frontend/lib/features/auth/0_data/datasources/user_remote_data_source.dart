import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';

abstract class UserRemoteDatasource {
  Future<UserEntity> registerUserInfoToDatabase({
    String? id,
    required String username,
    required String email,
    required String fullname,
    required String password,
  });
  Future<UserEntity> loggedInUserFromDatabase({
    String? id,
    required String email,
    required String password,
  });
  Future<UserEntity> userDetailsFromDatabase();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final String baseUrl = dotenv.env['URL'] ?? 'default_url';

  @override
  Future<UserEntity> registerUserInfoToDatabase({
    String? id,
    required String username,
    required String email,
    required String fullname,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${baseUrl}auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'fullname': fullname,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      return UserEntity(
        id: json.decode(response.body)['id'],
        email: email,
        fullname: fullname,
        username: username,
      );
    } else {
      throw Exception('Failed to register user');
    }
  }

  @override
  Future<UserEntity> loggedInUserFromDatabase({
    String? id,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${dotenv.get('')}auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      // final responseData = json.decode(response.body);
      // return responseData;
      return UserEntity(
        id: json.decode(response.body)['id'],
        email: email,
        fullname: json.decode(response.body)['fullname'],
        username: json.decode(response.body)['username'],
      );
    } else {
      throw Exception('Failed to register user');
    }
  }

  @override
  Future<UserEntity> userDetailsFromDatabase() {
    // TODO: implement userDetailsFromDatabase
    throw UnimplementedError();
  }
}
