import 'package:equatable/equatable.dart';

class SignupRequestModel extends Equatable {
  const SignupRequestModel({
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
  });

  final String username;
  final String fullname;
  final String email;
  final String password;

  @override
  List<Object> get props => [username, fullname, email, password];
}
