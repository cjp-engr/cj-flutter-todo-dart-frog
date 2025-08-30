import 'package:fpdart/fpdart.dart';
import 'package:todo_backend/core/entities/user_entity.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/auth/domain/dtos/response/signup_response_model.dart';
import 'package:todo_backend/features/auth/domain/presenters/auth_presenter.dart';

class AuthPresenterImpl implements AuthPresenter {
  @override
  EitherOr<SignupResponseModel> signupPresenter(EitherOr<User> result) {
    final EitherOr<SignupResponseModel> response = result.match(
      Left.new,
      (user) => Right(SignupResponseModel(id: user.id)),
    );

    return response;
  }
}
