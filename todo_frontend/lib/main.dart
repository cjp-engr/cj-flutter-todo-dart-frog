import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:todo_frontend/core/services/theme_service.dart';
import 'package:todo_frontend/l10n/app_localizations.dart';
import 'package:todo_frontend/injection.dart';
import 'package:todo_frontend/theme.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp(router: sl()));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode: themeService.isDarkModeOn
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
