import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:todo_backend/core/db/db_connection.dart';
import 'package:todo_backend/core/services/bearer_authenticator.dart';
import 'package:todo_backend/env/env.dart';
import 'package:todo_backend/features/todos/1_domain/presenters/todo_presenter.dart';
import 'package:todo_backend/features/todos/1_domain/repositories/todo_repository.dart';
import 'package:todo_backend/features/todos/1_domain/usecases/create_todo_usecase.dart';
import 'package:todo_backend/features/todos/1_domain/usecases/delete_todo_usecase.dart';
import 'package:todo_backend/features/todos/1_domain/usecases/fetch_todo_usecase.dart';
import 'package:todo_backend/features/todos/1_domain/usecases/fetch_todos_usecase.dart';
import 'package:todo_backend/features/todos/1_domain/usecases/toggle_todo_usecase.dart';
import 'package:todo_backend/features/todos/1_domain/usecases/update_todo_usecase.dart';
import 'package:todo_backend/features/todos/2_data/datasources/postgres_todo_data_source.dart';
import 'package:todo_backend/features/todos/2_data/datasources/todo_data_source.dart';
import 'package:todo_backend/features/todos/2_data/repositories/todo_repository_impl.dart';
import 'package:todo_backend/features/todos/3_presentation/controllers/todo_controller.dart';
import 'package:todo_backend/features/todos/3_presentation/controllers/todo_controller_impl.dart';
import 'package:todo_backend/features/todos/3_presentation/presenters/todo_presenter_impl.dart';
import 'package:todo_backend/features/users/1_domain/dtos/response/user_response_model.dart';

TodoController? _todoController;
CreateTodoUsecase? _createTodoUsecase;
FetchTodosUsecase? _fetchTodosUsecase;
FetchTodoUsecase? _fetchTodoUsecase;
ToggleTodoUsecase? _toggleTodoUsecase;
UpdateTodoUsecase? _updateTodoUsecase;
DeleteTodoUsecase? _deleteTodoUsecase;
TodoRepository? _todoRepository;
TodoPresenter? _todoPresenter;
TodoDataSource? _todoDataSource;

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
        provider<TodoController>(
          (context) => _todoController ??= TodoControllerImpl(
            createTodoUsecase: context.read<CreateTodoUsecase>(),
            fetchTodosUsecase: context.read<FetchTodosUsecase>(),
            fetchTodoUsecase: context.read<FetchTodoUsecase>(),
            toggleTodoUsecase: context.read<ToggleTodoUsecase>(),
            updateTodoUsecase: context.read<UpdateTodoUsecase>(),
            deleteTodoUsecase: context.read<DeleteTodoUsecase>(),
          ),
        ),
      )
      .use(
        provider<CreateTodoUsecase>(
          (context) => _createTodoUsecase ??= CreateTodoUsecase(
            todoRepository: context.read<TodoRepository>(),
            todoPresenter: context.read<TodoPresenter>(),
          ),
        ),
      )
      .use(
        provider<FetchTodosUsecase>(
          (context) => _fetchTodosUsecase ??= FetchTodosUsecase(
            todoRepository: context.read<TodoRepository>(),
            todoPresenter: context.read<TodoPresenter>(),
          ),
        ),
      )
      .use(
        provider<FetchTodoUsecase>(
          (context) => _fetchTodoUsecase ??= FetchTodoUsecase(
            todoRepository: context.read<TodoRepository>(),
            todoPresenter: context.read<TodoPresenter>(),
          ),
        ),
      )
      .use(
        provider<ToggleTodoUsecase>(
          (context) => _toggleTodoUsecase ??= ToggleTodoUsecase(
            todoRepository: context.read<TodoRepository>(),
            todoPresenter: context.read<TodoPresenter>(),
          ),
        ),
      )
      .use(
        provider<UpdateTodoUsecase>(
          (context) => _updateTodoUsecase ??= UpdateTodoUsecase(
            todoRepository: context.read<TodoRepository>(),
            todoPresenter: context.read<TodoPresenter>(),
          ),
        ),
      )
      .use(
        provider<DeleteTodoUsecase>(
          (context) => _deleteTodoUsecase ??= DeleteTodoUsecase(
            todoRepository: context.read<TodoRepository>(),
          ),
        ),
      )
      .use(
        provider<TodoRepository>(
          (context) => _todoRepository ??= TodoRepositoryImpl(
            todoDataSource: context.read<TodoDataSource>(),
          ),
        ),
      )
      .use(
        provider<TodoPresenter>(
          (context) => _todoPresenter ??= TodoPresenterImpl(),
        ),
      )
      .use(
        provider<TodoDataSource>((context) {
          if (env[Env.activeDb] == 'postgres') {
            return _todoDataSource ??= PostgresTodoDataSource(
              dbConnection: context.read<DbConnection>(),
            );
          } else {
            // return _todoDataSource ??= MongoTodoDataSource(
            //   dbConnection: context.read<DbConnection>(),
            // );
            return _todoDataSource ??= PostgresTodoDataSource(
              dbConnection: context.read<DbConnection>(),
            );
          }
        }),
      );
}
