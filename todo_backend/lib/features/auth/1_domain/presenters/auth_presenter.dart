import 'package:todo_backend/core/entities/user_entity.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/auth/1_domain/dtos/request/signin_request_model.dart';
import 'package:todo_backend/features/auth/1_domain/dtos/response/signup_response_model.dart';

abstract interface class AuthPresenter {
  EitherOr<SignupResponseModel> signupPresenter(EitherOr<User> result);

  EitherOr<SigninResponseModel> signinPresenter(EitherOr<User> result);
}
