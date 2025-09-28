import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_frontend/core/constants/font_size.dart';
import 'package:todo_frontend/core/constants/spacing.dart';
import 'package:todo_frontend/core/extension/bloc_api_status.dart';
import 'package:todo_frontend/core/routes/route_name.dart';
import 'package:todo_frontend/core/utils/icon_const.dart';
import 'package:todo_frontend/core/widgets/app_bar.dart';
import 'package:todo_frontend/core/widgets/buttons.dart';
import 'package:todo_frontend/core/widgets/progress_indicator.dart';
import 'package:todo_frontend/core/widgets/text.dart';
import 'package:todo_frontend/features/todos/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:todo_frontend/features/todos/2_application/pages/all_todos/widgets/list.dart';
import 'package:todo_frontend/injection.dart';

class AllTodosPageWrapper extends StatelessWidget {
  const AllTodosPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<AllTodosBloc>())],
      child: const AllTodosPage(),
    );
  }
}

class AllTodosPage extends StatelessWidget {
  const AllTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllTodosBloc, AllTodosState>(
      builder: (context, state) {
        if (state.status == BlocStatus.loading ||
            state.status == BlocStatus.initial) {
          return const TodoProgressIndicator();
        }
        if (state.status == BlocStatus.error) {
          return const Text('test you cannot register, sorry');
        }

        return TodoAppBar(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TodoSpacing.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TodoText(
                  text: 'Hello, Carmen!',
                  fontSize: TodoFontSize.large,
                  color: Colors.black45,
                ),
                TodoText(
                  text: 'All Todos (${state.todos.length})',
                  fontSize: TodoFontSize.extraLarge,
                  fontWeight: FontWeight.bold,
                ),
                ListWidget(todos: state.todos),
                const SizedBox(height: TodoSpacing.large),
              ],
            ),
          ),
          floatingActionButton: const _AddTodoWidget(),
        );
      },
    );
  }
}

class _AddTodoWidget extends StatelessWidget {
  const _AddTodoWidget();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.goNamed(
          TodoRouteName.todoForm.name,
          pathParameters: {'action': 'add', 'index': ' '},
        );
      },
      label: const Row(
        children: [
          TodoText(text: 'Write a new todo', textAlign: TextAlign.left),
          SizedBox(width: TodoSpacing.extraSmall),
          Icon(Icons.add, color: Colors.white, size: 28),
        ],
      ),
    );
  }
}
