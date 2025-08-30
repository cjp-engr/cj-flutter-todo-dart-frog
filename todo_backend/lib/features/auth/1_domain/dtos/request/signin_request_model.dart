import 'package:equatable/equatable.dart';
import 'package:todo_backend/core/typedefs/typedefs.dart';

class SigninResponseModel extends Equatable {
  const SigninResponseModel({required this.id});

  final String id;

  @override
  List<Object> get props => [id];

  MapData toJson() {
    return {'id': id};
  }
}
