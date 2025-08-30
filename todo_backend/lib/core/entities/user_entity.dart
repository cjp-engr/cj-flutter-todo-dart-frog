// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
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
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
    id,
    username,
    fullname,
    email,
    createdAt,
    updatedAt,
  ];

  @override
  String toString() {
    return 'User(id: $id, username: $username, fullname: $fullname, email: $email, '
        'createdAt: $createdAt, updatedAt: $updatedAt,)';
  }
}
