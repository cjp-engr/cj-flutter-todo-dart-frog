import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';

abstract class UserRepo {
  Future<Either<Failure, UserEntity>> registerUserToDataSource({
    required String username,
    required String email,
    required String fullname,
    required String password,
  });

  Future<Either<Failure, UserEntity>> loggedInExistingUserFromDataSource({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> userDetailsFromDataSource();
}
