import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/users/1_domain/dtos/request/change_password_request_model.dart';
import 'package:todo_backend/features/users/1_domain/dtos/response/user_response_model.dart';
import 'package:todo_backend/features/users/1_domain/presenters/user_presenter.dart';
import 'package:todo_backend/features/users/1_domain/repositories/user_repository.dart';

class ChangePasswordUsecase
    implements Usecase<UserResponseModel, ChangePasswordRequestModel> {
  ChangePasswordUsecase({
    required UserRepository userRepository,
    required UserPresenter userPresenter,
  }) : _userRepository = userRepository,
       _userPresenter = userPresenter;

  final UserRepository _userRepository;
  final UserPresenter _userPresenter;

  @override
  FutureEither<UserResponseModel> call(
    ChangePasswordRequestModel params,
  ) async {
    final result = await _userRepository.changePassword(
      userId: params.userId,
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
    );

    final response = _userPresenter.changePasswordPresenter(result);

    return response;
  }
}
