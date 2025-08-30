import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/auth/1_domain/dtos/request/signin_request_model.dart';
import 'package:todo_backend/features/auth/1_domain/dtos/response/signin_response_model.dart';
import 'package:todo_backend/features/auth/1_domain/presenters/auth_presenter.dart';
import 'package:todo_backend/features/auth/1_domain/repositories/auth_repository.dart';

class SigninUsecase
    implements Usecase<SigninResponseModel, SigninRequestModel> {
  SigninUsecase({
    required AuthRepository authRepository,
    required AuthPresenter authPresenter,
  }) : _authRepository = authRepository,
       _authPresenter = authPresenter;

  final AuthRepository _authRepository;
  final AuthPresenter _authPresenter;

  @override
  FutureEither<SigninResponseModel> call(SigninRequestModel params) async {
    final result = await _authRepository.signin(
      email: params.email,
      password: params.password,
    );

    final response = _authPresenter.signinPresenter(result);

    return response;
  }
}
