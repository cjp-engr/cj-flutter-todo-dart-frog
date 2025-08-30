import 'package:fpdart/fpdart.dart';
import 'package:todo_backend/core/entities/user_entity.dart';
import 'package:todo_backend/core/errors/exceptions.dart';
import 'package:todo_backend/core/errors/failures.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/auth/data/datasources/auth_data_source.dart';
import 'package:todo_backend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthDataSource authDataSource})
    : _authDataSource = authDataSource;

  final AuthDataSource _authDataSource;
  @override
  FutureEither<User> signup({
    required String username,
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      final user = await _authDataSource.signup(
        username: username,
        email: email,
        fullname: fullname,
        password: password,
      );

      return Right(user);
    } on TodoApiException catch (e) {
      return Left(TodoApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
