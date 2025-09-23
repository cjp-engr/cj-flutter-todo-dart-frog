import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/failures/failures.dart';

abstract class UseCase<T, ParamsType> {
  Future<Either<Failure, T>> call(ParamsType params);
}

abstract class UseCaseNoParams<T> {
  Future<Either<Failure, T>> call();
}

abstract class UseCaseNoParamsNoAsync<T> {
  Either<Failure, T> call();
}
