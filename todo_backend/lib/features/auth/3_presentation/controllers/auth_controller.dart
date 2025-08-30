import 'package:dart_frog/dart_frog.dart';

abstract interface class AuthController {
  Future<Response> signup(RequestContext context);
}
