import 'package:todo_backend/core/models/user_model.dart';

abstract interface class AuthDataSource {
  Future<UserModel> signup({
    required String username,
    required String email,
    required String fullname,
    required String password,
  });
}
