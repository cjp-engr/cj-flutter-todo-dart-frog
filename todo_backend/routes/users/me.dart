import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todo_backend/features/users/3_presentation/controllers/user_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  final userController = context.read<UserController>();

  switch (context.request.method) {
    case HttpMethod.get:
      return userController.getMe(context);
    case HttpMethod.put:
      return userController.updateMe(context);
    case HttpMethod.delete:
      return userController.deleteMe(context);
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
