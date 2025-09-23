import 'package:equatable/equatable.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';

class LoginModel extends UserEntity with EquatableMixin {
  LoginModel({
    required super.id,
    required super.email,
    required super.fullname,
    required super.username,
  });
}
