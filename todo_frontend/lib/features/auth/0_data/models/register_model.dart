import 'package:equatable/equatable.dart';
import 'package:todo_frontend/core/typedefs/typedefs.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';

class RegisterModel extends UserEntity with EquatableMixin {
  RegisterModel({required super.id, required super.token});

  factory RegisterModel.fromJson(MapData map) {
    return RegisterModel(
      id: map['id'] != null ? map['id'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }
}
