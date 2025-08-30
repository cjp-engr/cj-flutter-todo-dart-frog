import 'package:dartz/dartz.dart';
import 'package:todo_frontend/0_data/datasources/user_remote_data_source.dart';
import 'package:todo_frontend/0_data/exceptions/exceptions.dart';
import 'package:todo_frontend/1_domain/entities/user_entity.dart';
import 'package:todo_frontend/1_domain/failures/failures.dart';
import 'package:todo_frontend/1_domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepoImpl({required this.userRemoteDatasource});

  @override
  Future<Either<Failure, UserEntity>> registerUserToDataSource(
    UserEntity user,
  ) async {
    try {
      final result = await userRemoteDatasource.registerUserInfoToDatabase(
        user,
      );
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, String>> loggedInExistingUserFromDataSource(
    UserEntity user,
  ) async {
    try {
      final result = await userRemoteDatasource.loggedInUserFromDatabase(user);
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
