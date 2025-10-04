import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_frontend/core/constants/font_size.dart';
import 'package:todo_frontend/core/constants/spacing.dart';
import 'package:todo_frontend/core/extension/bloc_api_status.dart';
import 'package:todo_frontend/core/routes/route_name.dart';
import 'package:todo_frontend/core/utils/build_context_ext.dart';
import 'package:todo_frontend/core/utils/icon_const.dart';
import 'package:todo_frontend/core/widgets/app_bar.dart';
import 'package:todo_frontend/core/widgets/buttons.dart';
import 'package:todo_frontend/core/widgets/progress_indicator.dart';
import 'package:todo_frontend/core/widgets/text.dart';
import 'package:todo_frontend/core/widgets/text_field.dart';
import 'package:todo_frontend/features/auth/2_application/pages/settings/bloc/settings_bloc.dart';
import 'package:todo_frontend/features/auth/2_application/pages/settings/widgets/reset_password_dialog.dart';
import 'package:todo_frontend/injection.dart';

class SettingsPageWrapper extends StatelessWidget {
  const SettingsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<SettingsBloc>())],
      child: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state.status == BlocStatus.initial ||
            state.status == BlocStatus.loading) {
          return const TodoProgressIndicator();
        }
        return TodoAppBar(
          appBarLeading: Padding(
            padding: const EdgeInsets.all(TodoSpacing.verySmall),
            child: SecondaryButton(
              assetName: IconConst.back,
              onPressed: () {
                context.goNamed(TodoRouteName.allTodo.name);
              },
            ),
          ),
          appBarActions: [
            SecondaryButton(assetName: IconConst.logout, onPressed: () => null),
          ],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TodoSpacing.medium),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Center(
                  //   child: CircleAvatar(
                  //     radius: 75,
                  //     backgroundImage: NetworkImage(
                  //       'https://picsum.photos/seed/picsum/200/500',
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: TodoSpacing.verySmall),
                  TodoTextField(
                    label: 'Full Name',
                    controller: _fullNameController,
                    initialValue: state.user.fullname ?? '',
                  ),
                  const SizedBox(height: TodoSpacing.extraSmall),
                  TodoTextField(
                    label: 'Email',
                    controller: _emailController,
                    initialValue: state.user.email ?? '',
                  ),
                  const SizedBox(height: TodoSpacing.medium),
                  const Divider(),
                  const SizedBox(height: TodoSpacing.medium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TodoText(
                        text: 'Dark Mode',
                        fontWeight: FontWeight.bold,
                        fontSize: TodoFontSize.large,
                      ),
                      CupertinoSwitch(
                        value: true,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: TodoSpacing.medium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      PrimaryButton(
                        text: 'Reset Password',
                        width: context.screenWidth / 3,
                        onPressed: () => showResetPasswordDialog(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              _validateForm();
            },
            label: const SecondaryButton(assetName: IconConst.save),
          ),
        );
      },
    );
  }

  void _validateForm() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
  }
}
