import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_frontend/core/routes/route_name.dart';
import 'package:todo_frontend/core/routes/router_observer.dart';
import 'package:todo_frontend/core/storage/secure_storage.dart';
import 'package:todo_frontend/core/widgets/navigation_bar.dart';
import 'package:todo_frontend/features/auth/2_application/pages/login/login_page.dart';
import 'package:todo_frontend/features/auth/2_application/pages/register/register_page.dart';
import 'package:todo_frontend/features/auth/2_application/pages/settings/settings_page.dart';

import 'package:todo_frontend/features/todos/2_application/pages/active_todos/active_todos_page.dart';
import 'package:todo_frontend/features/todos/2_application/pages/all_todos/all_todos_page.dart';
import 'package:todo_frontend/features/todos/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:todo_frontend/features/todos/2_application/pages/completed_todos/completed_todos_page.dart';
import 'package:todo_frontend/features/todos/2_application/pages/todo_form/todo_form_page.dart';
import 'package:todo_frontend/injection.dart';

GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
Future<GoRouter> routerFactory(FlutterSecureStorage storage) async {
  final accessToken = await storage.read(key: SecureStorageKeys.accessToken);
  List<GoRoute> bottomNavigationBranches = [
    _allTodos(),
    _activeTodos(),
    _completedTodos(),
  ];
  //https://github.com/NonymousMorlock/shell_routing_practice?tab=readme-ov-file
  return GoRouter(
    initialLocation: accessToken?.isNotEmpty ?? false
        ? TodoRouteName.allTodo.path
        : TodoRouteName.login.path,
    navigatorKey: _rootNavigatorKey,
    observers: [GoRouterObserver()],
    routes: [
      _login(),
      _register(),
      _todoForm(),
      _settings(),
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (_, state, child) =>
            TodoNavigationBar(state: state, child: child),
        routes: bottomNavigationBranches,
      ),
    ],
  );
}

GoRoute _login() {
  return GoRoute(
    path: TodoRouteName.login.path,
    name: TodoRouteName.login.name,
    pageBuilder: (context, state) =>
        const NoTransitionPage(child: LoginPageWrapperProvider()),
  );
}

GoRoute _todoForm() {
  return GoRoute(
    path: '${TodoRouteName.todoForm.path}/:action/:index',
    name: TodoRouteName.todoForm.name,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        child: BlocProvider(
          create: (context) => sl<AllTodosBloc>(),
          child: state.pathParameters['action'] == 'add'
              ? const TodoFormPage(isAddForm: true, index: -1)
              : TodoFormPage(
                  isAddForm: false,
                  index: int.tryParse(state.pathParameters['index']!)!,
                ),
        ),
      );
    },
  );
}

GoRoute _register() {
  return GoRoute(
    path: TodoRouteName.register.path,
    name: TodoRouteName.register.name,
    pageBuilder: (context, state) =>
        const NoTransitionPage(child: RegisterPageWrapperProvider()),
  );
}

GoRoute _settings() {
  return GoRoute(
    path: TodoRouteName.settings.path,
    name: TodoRouteName.settings.name,
    pageBuilder: (context, state) =>
        const NoTransitionPage(child: SettingsPageWrapper()),
  );
}

GoRoute _allTodos() {
  return GoRoute(
    path: TodoRouteName.allTodo.path,
    name: TodoRouteName.allTodo.name,
    pageBuilder: (context, state) => _buildPageWithDefaultTransition<void>(
      context: context,
      state: state,
      child: const AllTodosPageWrapper(),
    ),
  );
}

GoRoute _activeTodos() {
  return GoRoute(
    path: TodoRouteName.activeTodo.path,
    name: TodoRouteName.activeTodo.name,
    pageBuilder: (context, state) => _buildPageWithDefaultTransition<void>(
      context: context,
      state: state,
      child: const ActiveTodosPageWrapper(),
    ),
  );
}

GoRoute _completedTodos() {
  return GoRoute(
    path: TodoRouteName.completedTodo.path,
    name: TodoRouteName.completedTodo.name,
    pageBuilder: (context, state) => _buildPageWithDefaultTransition<void>(
      context: context,
      state: state,
      child: const CompletedTodosPageWrapper(),
    ),
  );
}

CustomTransitionPage _buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
          opacity: CurveTween(curve: Curves.bounceInOut).animate(animation),
          child: child,
        ),
  );
}
