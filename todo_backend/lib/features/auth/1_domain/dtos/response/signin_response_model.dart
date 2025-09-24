import 'package:equatable/equatable.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';

class SigninResponseModel extends Equatable {
  const SigninResponseModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fullname,
  });

  final String id;
  final String username;
  final String email;
  final String fullname;

  @override
  List<Object> get props => [id, username, email, fullname];

  MapData toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullname': fullname,
    };
  }
}
