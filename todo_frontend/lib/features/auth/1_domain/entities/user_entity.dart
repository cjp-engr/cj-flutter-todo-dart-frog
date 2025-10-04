// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:todo_frontend/core/typedefs/typedefs.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final String? fullname;
  final String? username;
  final String? password;
  final String? token;

  const UserEntity({
    this.id,
    this.email,
    this.fullname,
    this.username,
    this.password,
    this.token,
  });

  @override
  List<Object?> get props => [id, email, fullname, username, password, token];

  UserEntity copyWith({
    String? id,
    String? email,
    String? fullname,
    String? username,
    String? password,
    String? token,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }

  MapData toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'fullname': fullname,
      'username': username,
      'password': password,
    };
  }

  factory UserEntity.fromJson(MapData map) {
    return UserEntity(
      id: map['id'] != null ? map['id'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());
}
