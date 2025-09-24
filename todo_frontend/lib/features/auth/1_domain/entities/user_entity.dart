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

  UserEntity copyWith({
    String? id,
    String? email,
    String? fullname,
    String? username,
    String? password,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      password: password ?? this.password,
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
      email: map['email'] as String,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());
}
