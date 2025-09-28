import 'package:equatable/equatable.dart';

class UpdateMeRequestModel extends Equatable {
  const UpdateMeRequestModel({
    required this.userId,
    this.username,
    this.email,
    this.fullname,
  });

  final String userId;
  final String? username;
  final String? email;
  final String? fullname;

  @override
  List<Object?> get props => [userId, username, email, fullname];
}
