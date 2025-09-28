import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todo_backend/features/users/3_presentation/controllers/user_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  final userController = context.read<UserController>();

  switch (context.request.method) {
    case HttpMethod.put:
      return userController.changePassword(context);
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
