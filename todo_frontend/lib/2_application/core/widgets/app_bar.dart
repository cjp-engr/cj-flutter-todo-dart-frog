// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:todo_frontend/2_application/core/utils/build_context_ext.dart';

// ignore: must_be_immutable
class TodoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? appBarLeading;
  final Widget? appBarTitle;
  final Widget? floatingActionButton;

  final Widget? body;
  List<Widget>? appBarActions;

  bool isNestedScrollView;
  TodoAppBar({
    super.key,
    this.appBarLeading,
    this.appBarTitle,
    this.floatingActionButton,
    this.body,
    this.appBarActions,
    this.isNestedScrollView = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: floatingActionButton,
          appBar: AppBar(
            leading: appBarLeading,
            title: appBarTitle,
            actions: [
              ...appBarActions ?? [],
              SizedBox(width: context.padding),
            ],
          ),
          body: AdaptiveLayout(
            body: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.small: SlotLayout.from(
                  key: const Key('smallBody'),
                  builder: (_) => body ?? const SizedBox(),
                ),
                Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('mediumAndUpBody'),
                  builder: (_) => SingleChildScrollView(child: body!),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
