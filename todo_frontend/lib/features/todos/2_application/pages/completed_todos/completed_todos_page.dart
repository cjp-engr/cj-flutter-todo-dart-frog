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
import 'package:todo_frontend/core/widgets/text_field.dart';
import 'package:todo_frontend/features/todos/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:todo_frontend/features/todos/2_application/pages/completed_todos/bloc/completed_todo_bloc.dart';
import 'package:todo_frontend/injection.dart';

class CompletedTodosPageWrapper extends StatelessWidget {
  const CompletedTodosPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AllTodosBloc>()),
        BlocProvider(create: (_) => sl<CompletedTodoBloc>()),
      ],
      child: const CompletedTodosPage(),
    );
  }
}

class CompletedTodosPage extends StatelessWidget {
  const CompletedTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AllTodosBloc, AllTodosState>(
      listener: (context, allTodoState) {
        if (allTodoState.status == BlocStatus.success ||
            allTodoState.status == BlocStatus.loaded) {
          context.read<CompletedTodoBloc>().add(
            ReadCompletedTodosEvent(todos: allTodoState.todos),
          );
        }
      },
      child: BlocBuilder<CompletedTodoBloc, CompletedTodoState>(
        builder: (context, state) {
          if (state.status == BlocStatus.loading) {
            return const TodoProgressIndicator();
          }
          if (state.status == BlocStatus.error) {
            return const Text('test you cannot register, sorry');
          }
          return TodoAppBar(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TodoSpacing.small,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TodoText(
                    text: 'Completed (${state.filteredTodos.length})',
                    fontSize: TodoFontSize.extraLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: TodoSpacing.large),
                  const _SearchTodoWidget(),
                  const SizedBox(height: TodoSpacing.large),
                  state.filteredTodos.isEmpty
                      ? const Center(
                          child: TodoText(
                            text: 'No Completed Todos',
                            fontSize: TodoFontSize.medium,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      : Flexible(
                          child: ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.filteredTodos.length,
                            itemBuilder: (context, index) => SizedBox(
                              height: 100,
                              child: Card(
                                child: Row(
                                  children: [
                                    const SizedBox(width: TodoSpacing.small),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: TodoSpacing.extraSmall,
                                        ),
                                        TodoText(
                                          fontSize: TodoFontSize.veryLarge,
                                          text:
                                              state.filteredTodos[index].title,
                                          textAlign: TextAlign.left,
                                        ),
                                        TodoText(
                                          text: state
                                              .filteredTodos[index]
                                              .description,
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SearchTodoWidget extends StatelessWidget {
  const _SearchTodoWidget();

  @override
  Widget build(BuildContext context) {
    return TodoTextField(
      label: 'Search Title or Description...',
      onChanged: (entered) {
        context.read<CompletedTodoBloc>().add(
          SearchCompletedTodoEvent(searchTodo: entered),
        );
      },
    );
  }
}
