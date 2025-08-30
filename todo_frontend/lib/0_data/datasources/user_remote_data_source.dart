import 'package:todo_frontend/1_domain/entities/user_entity.dart';

abstract class UserRemoteDatasource {
  Future<UserEntity> registerUserInfoToDatabase(UserEntity user);
  Future<String> loggedInUserFromDatabase(UserEntity user);
  Future<UserEntity> userDetailsFromDatabase();
}
