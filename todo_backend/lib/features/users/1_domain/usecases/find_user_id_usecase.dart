import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/users/1_domain/dtos/request/find_user_by_id_model.dart';
import 'package:todo_backend/features/users/1_domain/dtos/response/user_response_model.dart';
import 'package:todo_backend/features/users/1_domain/presenters/user_presenter.dart';
import 'package:todo_backend/features/users/1_domain/repositories/user_repository.dart';

class FindUserByIdUsecase
    implements Usecase<UserResponseModel, FindUserByIdRequestModel> {
  FindUserByIdUsecase({
    required UserRepository userRepository,
    required UserPresenter userPresenter,
  }) : _userRepository = userRepository,
       _userPresenter = userPresenter;

  final UserRepository _userRepository;
  final UserPresenter _userPresenter;

  @override
  FutureEither<UserResponseModel> call(FindUserByIdRequestModel params) async {
    final result = await _userRepository.findUserById(userId: params.userId);

    final response = _userPresenter.findUserByIdPresenter(result);

    return response;
  }
}
