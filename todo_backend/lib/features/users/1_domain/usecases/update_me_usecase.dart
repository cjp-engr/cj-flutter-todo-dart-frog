import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/users/1_domain/dtos/request/update_me_request_model.dart';
import 'package:todo_backend/features/users/1_domain/dtos/response/user_response_model.dart';
import 'package:todo_backend/features/users/1_domain/presenters/user_presenter.dart';
import 'package:todo_backend/features/users/1_domain/repositories/user_repository.dart';

class UpdateMeUsecase
    implements Usecase<UserResponseModel, UpdateMeRequestModel> {
  UpdateMeUsecase({
    required UserRepository userRepository,
    required UserPresenter userPresenter,
  }) : _userRepository = userRepository,
       _userPresenter = userPresenter;

  final UserRepository _userRepository;
  final UserPresenter _userPresenter;

  @override
  FutureEither<UserResponseModel> call(UpdateMeRequestModel params) async {
    final result = await _userRepository.updateMe(
      userId: params.userId,
      username: params.username,
      email: params.email,
      fullname: params.fullname,
    );

    final response = _userPresenter.updateMePresenter(result);

    return response;
  }
}
