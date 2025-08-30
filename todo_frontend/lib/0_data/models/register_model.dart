import 'package:equatable/equatable.dart';
import 'package:todo_frontend/1_domain/entities/user_entity.dart';

class RegisterModel extends UserEntity with EquatableMixin {
  RegisterModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.username,
  });
}
