import 'package:todo_backend/core/entities/user_entity.dart';

import '../../../../core/typedefs/typedefs.dart';

abstract interface class AuthRepository {
  FutureEither<User> signup({
    required String username,
    required String email,
    required String fullname,
    required String password,
  });

  FutureEither<User> signin({required String email, required String password});
}
