import 'package:patrol/patrol.dart';
import 'package:todo_frontend/core/utils/keys.dart';

class LoginTestPage {
  final PatrolIntegrationTester t;

  LoginTestPage(this.t);

  Future<void> loginWithEmail() async {
    await t(K.emailTextField).enterText(const String.fromEnvironment('EMAIL'));
    await t(
      K.passwordTextField,
    ).enterText(const String.fromEnvironment('PASSWORD'));
    await t(K.loginButton).tap();
  }
}
