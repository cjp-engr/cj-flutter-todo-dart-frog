import 'package:dartz/dartz.dart';
import 'package:todo_frontend/1_domain/entities/user_entity.dart';
import 'package:todo_frontend/1_domain/failures/failures.dart';
import 'package:todo_frontend/1_domain/repositories/user_repo.dart';
import 'package:todo_frontend/1_domain/usecases/base_use_case/use_case.dart';

class RegisterUserUC implements UseCase<UserEntity, dynamic> {
  final UserRepo userRepo;

  RegisterUserUC({required this.userRepo});

  @override
  Future<Either<Failure, UserEntity>> call(UserEntity user) async {
    try {
      return await userRepo.registerUserToDataSource(user);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

class LoggedInUserUC implements UseCase<UserEntity, dynamic> {
  final UserRepo userRepo;

  LoggedInUserUC({required this.userRepo});

  @override
  Future<Either<Failure, String>> call(UserEntity user) async {
    try {
      return await userRepo.loggedInExistingUserFromDataSource(user);
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}

class UserDetailsUC implements UseCaseNoParams {
  final UserRepo userRepo;

  UserDetailsUC({required this.userRepo});

  @override
  Future<Either<Failure, UserEntity>> call() async {
    try {
      return await userRepo.userDetailsFromDataSource();
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}
