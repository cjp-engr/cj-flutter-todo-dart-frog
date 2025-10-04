import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_frontend/core/routes/routes.dart';
import 'package:todo_frontend/core/storage/shared_preferences.dart';
import 'package:todo_frontend/core/storage/storage_interface.dart';
import 'package:todo_frontend/features/auth/0_data/datasources/user_remote_data_source.dart';
import 'package:todo_frontend/features/auth/0_data/repositories/user_repo_impl.dart';
import 'package:todo_frontend/features/auth/1_domain/repositories/user_repo.dart';
import 'package:todo_frontend/features/auth/1_domain/usecases/login_usecase.dart';
import 'package:todo_frontend/features/auth/1_domain/usecases/register_usecase.dart';
import 'package:todo_frontend/features/auth/1_domain/usecases/user_usecases.dart';
import 'package:todo_frontend/features/auth/2_application/pages/login/cubit/login_cubit.dart';
import 'package:todo_frontend/features/auth/2_application/pages/register/bloc/register_bloc.dart';
import 'package:todo_frontend/features/auth/2_application/pages/settings/bloc/settings_bloc.dart';
import 'package:todo_frontend/features/todos/0_data/datasources/todo_remote_data_source.dart';
import 'package:todo_frontend/features/todos/0_data/repositories/todo_repo_impl.dart';
import 'package:todo_frontend/features/todos/1_domain/repositories/todo_repo.dart';
import 'package:todo_frontend/features/todos/1_domain/usecases/todo_usecases.dart';
import 'package:todo_frontend/features/todos/2_application/pages/active_todos/bloc/active_todos_bloc.dart';
import 'package:todo_frontend/features/todos/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:todo_frontend/features/todos/2_application/pages/completed_todos/bloc/completed_todo_bloc.dart';

final sl = GetIt.I;

Future<void> init() async {
  //! application layer

  sl.registerFactory(() => LoginCubit(userUC: sl()));
  sl.registerFactory(() => RegisterBloc(userUC: sl()));
  sl.registerFactory(() => SettingsBloc(userDetailsUC: sl()));

  sl.registerFactory(
    () => AllTodosBloc(
      addTodoUC: sl(),
      readTodosUC: sl(),
      updateTodoUC: sl(),
      deleteTodoUC: sl(),
    ),
  );
  sl.registerFactory(() => ActiveTodosBloc(updateTodoUC: sl()));

  sl.registerFactory(() => CompletedTodoBloc());

  // ! domain Layer
  sl.registerFactory(() => LoggedInUserUC(userRepo: sl()));
  sl.registerFactory(() => RegisterUserUC(userRepo: sl()));
  sl.registerFactory(() => UserDetailsUC(userRepo: sl()));

  sl.registerFactory(() => AddTodoUC(todoRepo: sl()));
  sl.registerFactory(() => ReadTodosUC(todoRepo: sl()));
  sl.registerFactory(() => UpdateTodoUC(todoRepo: sl()));
  sl.registerFactory(() => DeleteTodoUC(todoRepo: sl()));

  // ! data Layer
  sl.registerFactory<UserRepo>(() => UserRepoImpl(userRemoteDatasource: sl()));
  sl.registerFactory<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(secureStorage: sl()),
  );

  sl.registerFactory<TodoRepo>(() => TodoRepoImpl(todoRemoteDatasource: sl()));
  sl.registerFactory<TodoRemoteDatasource>(
    () => TodoRemoteDatasourceImpl(secureStorage: sl()),
  );

  // ! externs
  sl.registerFactory(() => const FlutterSecureStorage());
  sl.registerFactory(() async => await SharedPreferences.getInstance());
  final SharedPreferences instance = await SharedPreferences.getInstance();
  sl.registerSingleton<AppStorage>(SharedPreferenceService(instance: instance));

  final GoRouter router = await routerFactory(sl());
  sl.registerSingleton(router);
}
