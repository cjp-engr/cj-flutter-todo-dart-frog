import 'package:flutter/material.dart';
import 'package:todo_frontend/core/constants/font_size.dart';
import 'package:todo_frontend/core/constants/spacing.dart';
import 'package:todo_frontend/core/widgets/text.dart';
import 'package:todo_frontend/core/widgets/text_field.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TodoText(text: 'x items left', fontSize: TodoFontSize.large),
          ],
        ),
        TodoTextField(label: 'Search Todos...'),
        const SizedBox(height: TodoSpacing.large),
      ],
    );
  }
}
