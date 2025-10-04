import 'package:equatable/equatable.dart';
import 'package:todo_frontend/core/typedefs/typedefs.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';

class LoginModel extends UserEntity with EquatableMixin {
  LoginModel({required super.id, required super.token});

  factory LoginModel.fromJson(MapData map) {
    return LoginModel(
      id: map['id'] != null ? map['id'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }
}
