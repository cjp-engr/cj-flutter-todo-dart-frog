import 'package:todo_backend/core/entities/user_entity.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/features/auth/domain/dtos/response/signup_response_model.dart';

abstract interface class AuthPresenter {
  EitherOr<SignupResponseModel> signupPresenter(
    EitherOr<User> result,
  );
}
