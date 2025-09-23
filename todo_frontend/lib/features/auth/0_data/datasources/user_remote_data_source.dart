import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:todo_frontend/env/env.dart';
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
  @override
  Future<UserEntity> registerUserInfoToDatabase({
    String? id,
    required String username,
    required String email,
    required String fullname,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('http://192.168.100.11:8080/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': 'username',
        'email': 'email@email.com',
        'fullname': 'fullname',
        'password': 'password',
      }),
    );
    if (kDebugMode) {
      print('testResponseStatus: ${response.statusCode}');
    }
    if (response.statusCode == 201) {
      if (kDebugMode) {
        print(
          'testResponse: ${UserEntity.fromJson(json.decode(response.body))}',
        );
      }
      return UserEntity.fromJson(json.decode(response.body));
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
      Uri.parse('${env[Env.localHost]}:8080/auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      return responseData;
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
