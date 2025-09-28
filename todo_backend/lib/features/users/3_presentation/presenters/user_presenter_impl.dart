import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:todo_backend/core/entities/user_entity.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/users/1_domain/dtos/response/user_response_model.dart';
import 'package:todo_backend/features/users/1_domain/presenters/user_presenter.dart';

class UserPresenterImpl implements UserPresenter {
  UserResponseModel _convertUserEntityToUserResponseModel(User user) {
    return UserResponseModel(
      id: user.id,
      username: user.username,
      email: user.email,
      fullname: user.fullname,
      createdAt: DateFormat(
        'E,MMM dd,yyyy - HH:mm:ss a',
      ).format(user.createdAt),
      updatedAt: DateFormat(
        'E,MMM dd,yyyy - HH:mm:ss a',
      ).format(user.updatedAt),
    );
  }

  @override
  EitherOr<UserResponseModel> findUserByIdPresenter(EitherOr<User> result) {
    final EitherOr<UserResponseModel> response = result.match(
      Left.new,
      (user) => Right(_convertUserEntityToUserResponseModel(user)),
    );

    return response;
  }

  @override
  EitherOr<UserResponseModel> updateMePresenter(EitherOr<User> result) {
    final EitherOr<UserResponseModel> response = result.match(
      Left.new,
      (user) => Right(_convertUserEntityToUserResponseModel(user)),
    );

    return response;
  }

  @override
  EitherOr<UserResponseModel> changePasswordPresenter(EitherOr<User> result) {
    final EitherOr<UserResponseModel> response = result.match(
      Left.new,
      (user) => Right(_convertUserEntityToUserResponseModel(user)),
    );

    return response;
  }
}
