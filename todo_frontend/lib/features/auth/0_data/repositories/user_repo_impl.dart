import 'package:todo_frontend/core/exceptions/exceptions.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/auth/0_data/datasources/user_remote_data_source.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';
import 'package:todo_frontend/features/auth/1_domain/repositories/user_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepoImpl({required this.userRemoteDatasource});

  @override
  Future<Either<Failure, UserEntity>> registerUserToDataSource({
    required String username,
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      final result = await userRemoteDatasource.registerUserInfoToDatabase(
        username: username,
        email: email,
        fullname: fullname,
        password: password,
      );
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loggedInExistingUserFromDataSource({
    required String email,
    required String password,
  }) async {
    try {
      final result = await userRemoteDatasource.loggedInUserFromDatabase(
        email: email,
        password: password,
      );
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> userDetailsFromDataSource() async {
    try {
      final result = await userRemoteDatasource.userDetailsFromDatabase();
      return right(result);
    } catch (_) {
      return left(GeneralFailure());
    }
  }
}
