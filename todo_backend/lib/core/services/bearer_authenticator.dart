import 'package:dart_frog/dart_frog.dart';
import 'package:todo_backend/core/services/jwt_service.dart';
import 'package:todo_backend/features/users/1_domain/dtos/request/find_user_by_id_model.dart';
import 'package:todo_backend/features/users/1_domain/dtos/response/user_response_model.dart';
import 'package:todo_backend/features/users/1_domain/usecases/find_user_id_usecase.dart';

class BearerAuthenticator {
  BearerAuthenticator({
    required JwtService jwtService,
    required FindUserByIdUsecase findUserByIdUsecase,
  }) : _jwtService = jwtService,
       _findUserByIdUsecase = findUserByIdUsecase;

  final JwtService _jwtService;
  final FindUserByIdUsecase _findUserByIdUsecase;

  Future<UserResponseModel?> authenticator(
    RequestContext context,
    String token,
  ) async {
    final payload = _jwtService.verify(token);

    if (payload == null) return null;

    final foundUser = await _findUserByIdUsecase(
      FindUserByIdRequestModel(userId: payload['id'] as String),
    );

    return foundUser.match((_) => null, (user) => user);
  }
}
