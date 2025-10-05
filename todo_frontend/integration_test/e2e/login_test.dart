import 'package:patrol/patrol.dart';

import '../pages/login_test_page.dart';
import 'common_actions.dart';

void main() {
  patrolTest('Validate user can login successfully', ($) async {
    await _initializeApp($);
    await _loginuser($);
  });
}

Future<void> _initializeApp(PatrolIntegrationTester $) async {
  CommonActions action = CommonActions($);
  await action.initializeApp();
}

Future<void> _loginuser(PatrolIntegrationTester $) async {
  LoginTestPage login = LoginTestPage($);
  await login.loginWithEmail();
}
