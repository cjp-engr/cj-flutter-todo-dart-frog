import 'package:fpdart/fpdart.dart';
import 'package:todo_frontend/core/failures/failures.dart';
import 'package:todo_frontend/features/todos/1_domain/dtos/response/todos_response_model.dart';
import 'package:todo_frontend/features/todos/1_domain/entities/todo_entity.dart';

abstract interface class TodosPresenter {
  Either<Failure, TodosResponseModel> todosPresenter(
    Either<Failure, TodoEntity> result,
  );
}
