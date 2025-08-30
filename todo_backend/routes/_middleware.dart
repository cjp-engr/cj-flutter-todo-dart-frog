import 'package:dart_frog/dart_frog.dart';
import 'package:todo_backend/core/services/jwt_service.dart';
import 'package:todo_backend/core/services/password_manager.dart';
import 'package:todo_backend/core/validators/input_validators.dart';

PasswordManager? _passwordManager;
JwtService? _jwtService;
InputValidators? _inputValidators;

Handler middleware(Handler handler) {
  return handler
      .use(provider<JwtService>((context) => _jwtService ??= JwtService()))
      .use(
        provider<PasswordManager>(
          (context) => _passwordManager ??= BcryptHashPassword(),
        ),
      )
      .use(
        provider<InputValidators>(
          (context) => _inputValidators ??= InputValidators(),
        ),
      );
}
