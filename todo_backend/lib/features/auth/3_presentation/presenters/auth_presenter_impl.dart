import 'package:fpdart/fpdart.dart';
import 'package:todo_backend/core/entities/user_entity.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/auth/1_domain/dtos/response/signin_response_model.dart';
import 'package:todo_backend/features/auth/1_domain/dtos/response/signup_response_model.dart';
import 'package:todo_backend/features/auth/1_domain/presenters/auth_presenter.dart';

class AuthPresenterImpl implements AuthPresenter {
  @override
  EitherOr<SignupResponseModel> signupPresenter(EitherOr<User> result) {
    final EitherOr<SignupResponseModel> response = result.match(
      Left.new,
      (user) => Right(SignupResponseModel(id: user.id)),
    );

    return response;
  }

  @override
  EitherOr<SigninResponseModel> signinPresenter(EitherOr<User> result) {
    final EitherOr<SigninResponseModel> response = result.match(
      Left.new,
      (user) => Right(
        SigninResponseModel(
          id: user.id,
          username: user.username,
          email: user.email,
          fullname: user.fullname,
        ),
      ),
    );

    return response;
  }
}
