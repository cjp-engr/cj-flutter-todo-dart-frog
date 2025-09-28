import 'package:todo_backend/core/entities/user_entity.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';

abstract interface class UserRepository {
  FutureEither<User> findUserById({required String userId});

  FutureEither<User> updateMe({
    required String userId,
    String? username,
    String? email,
    String? fullname,
  });

  FutureEither<User> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  });

  FutureEither<void> deleteMe({required String userId});
}
