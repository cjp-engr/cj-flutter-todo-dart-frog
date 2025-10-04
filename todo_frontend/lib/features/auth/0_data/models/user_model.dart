import 'package:equatable/equatable.dart';
import 'package:todo_frontend/core/typedefs/typedefs.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  UserModel({
    required super.id,
    required super.username,
    required super.fullname,
    required super.email,
  });

  factory UserModel.fromJson(MapData map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }
}
