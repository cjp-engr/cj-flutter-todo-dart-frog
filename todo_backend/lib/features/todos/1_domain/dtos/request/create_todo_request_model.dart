import 'package:equatable/equatable.dart';

class CreateTodoRequestModel extends Equatable {
  const CreateTodoRequestModel({
    required this.title,
    required this.description,
    required this.userId,
  });

  final String title;
  final String description;
  final String userId;

  @override
  List<Object> get props => [title, description, userId];
}
