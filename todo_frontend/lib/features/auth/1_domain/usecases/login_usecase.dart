import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/base_use_case/use_case.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';
import 'package:todo_frontend/features/auth/1_domain/repositories/user_repo.dart';

class LoggedInUserUC implements UseCase<dynamic, UserEntity> {
  final UserRepo userRepo;

  LoggedInUserUC({required this.userRepo});

  @override
  Future<Either<Failure, UserEntity>> call(UserEntity params) async {
    try {
      final result = await userRepo.loggedInExistingUserFromDataSource(
        email: params.email,
        password: params.password!,
      );
      return result;
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}
