import 'package:patrol/patrol.dart';
import 'package:todo_frontend/env/env.dart' as env;
import 'package:todo_frontend/injection.dart' as di;
import 'package:todo_frontend/injection.dart';
import 'package:todo_frontend/main.dart';

class CommonActions {
  final PatrolIntegrationTester t;

  CommonActions(this.t);

  Future<void> initializeApp() async {
    await di.init();
    await env.init();
    await t.pumpWidgetAndSettle(MyApp(router: sl()));
  }
}
