import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:todo_frontend/core/storage/secure_storage.dart';
import 'package:todo_frontend/features/auth/0_data/models/login_model.dart';
import 'package:todo_frontend/features/auth/0_data/models/register_model.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';

abstract class UserRemoteDatasource {
  Future<RegisterModel> registerUserInfoToDatabase({
    String? id,
    required String username,
    required String email,
    required String fullname,
    required String password,
  });
  Future<LoginModel> loggedInUserFromDatabase({
    String? id,
    required String email,
    required String password,
  });
  Future<UserEntity> userDetailsFromDatabase();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final FlutterSecureStorage secureStorage;

  UserRemoteDatasourceImpl({required this.secureStorage});

  final String baseUrl = dotenv.env['URL'] ?? 'default_url';

  @override
  Future<RegisterModel> registerUserInfoToDatabase({
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
      final data = json.decode(response.body);
      await secureStorage.write(
        key: SecureStorageKeys.accessToken,
        value: data['token'],
      );

      return RegisterModel.fromJson(data);
    } else {
      throw Exception('Failed to register user');
    }
  }

  @override
  Future<LoginModel> loggedInUserFromDatabase({
    String? id,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${baseUrl}auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      await secureStorage.write(
        key: SecureStorageKeys.accessToken,
        value: data['token'],
      );
      return LoginModel.fromJson(data);
    } else {
      throw Exception('Failed to register user');
    }
  }

  @override
  Future<UserEntity> userDetailsFromDatabase() async {
    final response = await http.get(
      Uri.parse('${baseUrl}users/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_TOKEN_HERE',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserEntity.fromJson(data);
    } else {
      throw Exception('Failed to register user');
    }
  }
}
