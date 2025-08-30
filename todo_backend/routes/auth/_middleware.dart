import 'package:dart_frog/dart_frog.dart';
import 'package:todo_backend/core/db/db_connection.dart';
import 'package:todo_backend/core/services/jwt_service.dart';
import 'package:todo_backend/core/services/password_manager.dart';
import 'package:todo_backend/core/validators/input_validators.dart';
import 'package:todo_backend/env/env.dart';
import 'package:todo_backend/features/auth/1_domain/presenters/auth_presenter.dart';
import 'package:todo_backend/features/auth/1_domain/repositories/auth_repository.dart';
import 'package:todo_backend/features/auth/1_domain/usecases/signin_usecase.dart';
import 'package:todo_backend/features/auth/1_domain/usecases/signup_usecase.dart';
import 'package:todo_backend/features/auth/2_data/datasources/auth_data_source.dart';
import 'package:todo_backend/features/auth/2_data/datasources/postgres_auth_data_source.dart';
import 'package:todo_backend/features/auth/2_data/repositories/auth_repository_impl.dart';
import 'package:todo_backend/features/auth/3_presentation/controllers/auth_controller.dart';
import 'package:todo_backend/features/auth/3_presentation/controllers/auth_controller_impl.dart';
import 'package:todo_backend/features/auth/3_presentation/presenters/auth_presenter_impl.dart';

AuthDataSource? _authDataSource;
AuthRepository? _authRepository;
AuthPresenter? _authPresenter;
SignupUsecase? _signupUsecase;
SigninUsecase? _signinUsecase;
AuthController? _authController;

Handler middleware(Handler handler) {
  return handler
      /// ====== controllers
      .use(
        provider<AuthController>(
          (context) => _authController ??= AuthControllerImpl(
            signupUsecase: context.read<SignupUsecase>(),
            signinUsecase: context.read<SigninUsecase>(),
            jwtService: context.read<JwtService>(),
            inputValidators: context.read<InputValidators>(),
          ),
        ),
      )
      /// ====== usecases
      .use(
        provider<SignupUsecase>(
          (context) => _signupUsecase ??= SignupUsecase(
            authRepository: context.read<AuthRepository>(),
            authPresenter: context.read<AuthPresenter>(),
          ),
        ),
      )
      .use(
        provider<SigninUsecase>(
          (context) => _signinUsecase ??= SigninUsecase(
            authRepository: context.read<AuthRepository>(),
            authPresenter: context.read<AuthPresenter>(),
          ),
        ),
      )
      /// ====== presenters
      .use(
        provider<AuthPresenter>(
          (context) => _authPresenter ??= AuthPresenterImpl(),
        ),
      )
      /// ====== repositories
      .use(
        provider<AuthRepository>(
          (context) => _authRepository ??= AuthRepositoryImpl(
            authDataSource: context.read<AuthDataSource>(),
          ),
        ),
      )
      /// ====== data sources
      .use(
        provider<AuthDataSource>((context) {
          if (env[Env.activeDb] == 'postgres') {
            return _authDataSource ??= PostgresAuthDataSource(
              dbConnection: context.read<DbConnection>(),
              passwordManager: context.read<PasswordManager>(),
            );
          } else {
            return _authDataSource ??= PostgresAuthDataSource(
              dbConnection: context.read<DbConnection>(),
              passwordManager: context.read<PasswordManager>(),
            );
          }
        }),
      );
}
