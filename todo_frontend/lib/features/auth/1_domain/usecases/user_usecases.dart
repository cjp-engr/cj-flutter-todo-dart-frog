import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/base_use_case/use_case.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';
import 'package:todo_frontend/features/auth/1_domain/repositories/user_repo.dart';

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
