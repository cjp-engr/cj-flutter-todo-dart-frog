import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todo_backend/core/services/jwt_service.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';
import 'package:todo_backend/core/validators/input_validators.dart';
import 'package:todo_backend/core/validators/validators_constants.dart';
import 'package:todo_backend/features/auth/1_domain/dtos/request/signup_request_model.dart';
import 'package:todo_backend/features/auth/1_domain/dtos/response/signin_response_model.dart';
import 'package:todo_backend/features/auth/1_domain/usecases/signin_usecase.dart';
import 'package:todo_backend/features/auth/1_domain/usecases/signup_usecase.dart';
import 'package:todo_backend/features/auth/3_presentation/controllers/auth_controller.dart';

class AuthControllerImpl implements AuthController {
  AuthControllerImpl({
    required SignupUsecase signupUsecase,
    required SigninUsecase signinUsecase,
    required JwtService jwtService,
    required InputValidators inputValidators,
  }) : _signupUsecase = signupUsecase,
       _signinUsecase = signinUsecase,
       _jwtService = jwtService,
       _inputValidators = inputValidators;

  final SignupUsecase _signupUsecase;
  final SigninUsecase _signinUsecase;
  final JwtService _jwtService;
  final InputValidators _inputValidators;

  @override
  Future<Response> signup(RequestContext context) async {
    final body = await context.request.json() as MapData;

    final username = body['username'] as String?;
    final email = body['email'] as String?;
    final fullname = body['fullname'] as String?;
    final password = body['password'] as String?;

    final errors = <String, String>{};

    if (username == null || _inputValidators.username(username)) {
      errors['username'] = ValidatorsConstants.invalidUsername;
    }

    if (email == null || _inputValidators.email(email)) {
      errors['email'] = ValidatorsConstants.invalidEmail;
    }

    if (fullname == null || _inputValidators.fullname(fullname)) {
      errors['fullname'] = ValidatorsConstants.invalidfullname;
    }

    if (password == null || _inputValidators.password(password)) {
      errors['password'] = ValidatorsConstants.invalidPassword;
    }

    if (errors.isNotEmpty) {
      return Response.json(statusCode: HttpStatus.badRequest, body: errors);
    }

    final result = await _signupUsecase(
      SignupRequestModel(
        username: username!,
        email: email!,
        fullname: fullname!,
        password: password!,
      ),
    );

    return result.match(
      (failure) {
        return Response.json(
          statusCode: failure.statusCode,
          body: {'message': failure.message},
        );
      },
      (user) {
        final payload = user.toJson();

        final token = _jwtService.sign(payload);

        return Response.json(
          statusCode: HttpStatus.created,
          body: {'token': token, 'id': user.id},
        );
      },
    );
  }

  @override
  Future<Response> signin(RequestContext context) async {
    final body = await context.request.json() as MapData;

    final email = body['email'] as String?;
    final password = body['password'] as String?;

    final errors = <String, String>{};

    if (email == null || _inputValidators.email(email)) {
      errors['email'] = ValidatorsConstants.invalidEmail;
    }

    if (password == null || _inputValidators.password(password)) {
      errors['password'] = ValidatorsConstants.invalidPassword;
    }

    if (errors.isNotEmpty) {
      return Response.json(statusCode: HttpStatus.badRequest, body: errors);
    }

    final result = await _signinUsecase(
      SigninRequestModel(email: email!, password: password!),
    );

    return result.match(
      (failure) {
        return Response.json(
          statusCode: failure.statusCode,
          body: {'message': failure.message},
        );
      },
      (user) {
        final payload = user.toJson();

        final token = _jwtService.sign(payload);

        return Response.json(body: {'token': token, 'id': user.id});
      },
    );
  }
}
