import 'package:json_annotation/json_annotation.dart';
import 'package:todo_backend/core/converters/converters.dart';
import 'package:todo_backend/core/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false)
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.fullname,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @JsonKey(readValue: idOrUnderscoreId)
  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String get fullname;
  @JsonKey(fromJson: fromDateTime, readValue: createdAtOrCreatedUnderscoreAt)
  @override
  DateTime get createdAt;
  @JsonKey(fromJson: fromDateTime, readValue: updatedAtOrUpdatedUnderscoreAt)
  @override
  DateTime get updatedAt;

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, '
        'fullname: $fullname, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? fullname,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
