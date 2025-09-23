import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:todo_frontend/core/constants/spacing.dart';
import 'package:todo_frontend/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get padding => Breakpoints.small.isActive(this)
      ? TodoSpacing.small
      : Breakpoints.medium.isActive(this)
      ? screenWidth * 0.12
      : screenWidth * 0.3;

  AppLocalizations get appLocalization => AppLocalizations.of(this)!;
}
