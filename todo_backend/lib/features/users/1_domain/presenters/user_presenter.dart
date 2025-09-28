import 'package:todo_backend/core/entities/user_entity.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/users/1_domain/dtos/response/user_response_model.dart';

abstract interface class UserPresenter {
  EitherOr<UserResponseModel> findUserByIdPresenter(EitherOr<User> result);

  EitherOr<UserResponseModel> updateMePresenter(EitherOr<User> result);

  EitherOr<UserResponseModel> changePasswordPresenter(EitherOr<User> result);
}
