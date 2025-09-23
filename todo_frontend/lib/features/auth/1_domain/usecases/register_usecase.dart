import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/base_use_case/use_case.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';
import 'package:todo_frontend/features/auth/1_domain/repositories/user_repo.dart';

class RegisterUserUC implements UseCase<dynamic, UserEntity> {
  final UserRepo userRepo;

  RegisterUserUC({required this.userRepo});

  @override
  Future<Either<Failure, UserEntity>> call(UserEntity params) async {
    try {
      final result = await userRepo.registerUserToDataSource(
        username: params.username!,
        email: params.email,
        fullname: params.fullname!,
        password: params.password!,
      );
      return result;
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}
