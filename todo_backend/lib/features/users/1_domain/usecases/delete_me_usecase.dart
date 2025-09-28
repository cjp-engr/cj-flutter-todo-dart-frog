import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/usecases/usecases.dart';
import 'package:todo_backend/features/users/1_domain/dtos/request/delete_me_request_model.dart';
import 'package:todo_backend/features/users/1_domain/repositories/user_repository.dart';

class DeleteMeUsecase implements Usecase<void, DeleteMeRequestModel> {
  DeleteMeUsecase({required UserRepository userRepository})
    : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  FutureEither<void> call(DeleteMeRequestModel params) async {
    final response = await _userRepository.deleteMe(userId: params.userId);

    return response;
  }
}
