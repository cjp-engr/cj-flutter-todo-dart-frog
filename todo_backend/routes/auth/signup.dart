import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todo_backend/features/auth/presentation/controllers/auth_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  final authController = context.read<AuthController>();

  switch (context.request.method) {
    case HttpMethod.post:
      return authController.signup(context);
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
