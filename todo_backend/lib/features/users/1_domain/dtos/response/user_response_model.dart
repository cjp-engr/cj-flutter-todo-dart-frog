import 'package:equatable/equatable.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';

class UserResponseModel extends Equatable {
  const UserResponseModel({
    required this.id,
    required this.username,
    required this.fullname,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String username;
  final String fullname;
  final String email;
  final String createdAt;
  final String updatedAt;

  @override
  List<Object> get props {
    return [id, username, fullname, email, createdAt, updatedAt];
  }

  MapData toJson() {
    return {
      'id': id,
      'username': username,
      'fullname': fullname,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
