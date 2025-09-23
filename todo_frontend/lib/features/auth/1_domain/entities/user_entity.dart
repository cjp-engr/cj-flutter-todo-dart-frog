// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:todo_frontend/core/typedefs/typedefs.dart';

class UserEntity extends Equatable {
  final String? id;
  final String email;
  final String? fullname;
  final String? username;
  final String? password;

  const UserEntity({
    this.id,
    required this.email,
    this.fullname,
    this.username,
    this.password,
  });

  @override
  List<Object?> get props => [id, email, fullname, username, password];

  MapData toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'fullname': fullname,
      'username': username,
      'password': password,
    };
  }

  factory UserEntity.fromMap(MapData map) {
    return UserEntity(
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] as String,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as MapData);
}
