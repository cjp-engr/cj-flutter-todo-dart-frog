import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:todo_backend/core/services/bearer_authenticator.dart';
import 'package:todo_backend/core/validators/input_validators.dart';
import 'package:todo_backend/features/users/1_domain/dtos/response/user_response_model.dart';
import 'package:todo_backend/features/users/1_domain/presenters/user_presenter.dart';
import 'package:todo_backend/features/users/1_domain/repositories/user_repository.dart';
import 'package:todo_backend/features/users/1_domain/usecases/change_password_usecase.dart';
import 'package:todo_backend/features/users/1_domain/usecases/delete_me_usecase.dart';
import 'package:todo_backend/features/users/1_domain/usecases/update_me_usecase.dart';
import 'package:todo_backend/features/users/3_presentation/controllers/user_controller.dart';
import 'package:todo_backend/features/users/3_presentation/controllers/user_controller_impl.dart';

UserController? _userController;
UpdateMeUsecase? _updateMeUsecase;
ChangePasswordUsecase? _changePasswordUsecase;
DeleteMeUsecase? _deleteMeUsecase;

Handler middleware(Handler handler) {
  return handler
      .use(
        bearerAuthentication<UserResponseModel>(
          authenticator: (context, token) async {
            final bearerAuthenticator = context.read<BearerAuthenticator>();
            return bearerAuthenticator.authenticator(context, token);
          },
        ),
      )
      .use(
        provider<UserController>(
          (context) => _userController ??= UserControllerImpl(
            inputValidators: context.read<InputValidators>(),
            updateMeUsecase: context.read<UpdateMeUsecase>(),
            changePasswordUsecase: context.read<ChangePasswordUsecase>(),
            deleteMeUsecase: context.read<DeleteMeUsecase>(),
          ),
        ),
      )
      .use(
        provider<DeleteMeUsecase>(
          (context) => _deleteMeUsecase ??= DeleteMeUsecase(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      )
      .use(
        provider<ChangePasswordUsecase>(
          (context) => _changePasswordUsecase ??= ChangePasswordUsecase(
            userRepository: context.read<UserRepository>(),
            userPresenter: context.read<UserPresenter>(),
          ),
        ),
      )
      .use(
        provider<UpdateMeUsecase>(
          (context) => _updateMeUsecase ??= UpdateMeUsecase(
            userRepository: context.read<UserRepository>(),
            userPresenter: context.read<UserPresenter>(),
          ),
        ),
      );
}
