import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todo_backend/features/todos/3_presentation/controllers/todo_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  final todoController = context.read<TodoController>();

  switch (context.request.method) {
    case HttpMethod.post:
      return todoController.createTodo(context);
    case HttpMethod.get:
      return todoController.fetchTodos(context);
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}
