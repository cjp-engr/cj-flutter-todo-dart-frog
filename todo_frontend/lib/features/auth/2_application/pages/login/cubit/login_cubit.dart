import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_frontend/core/extension/bloc_api_status.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';
import 'package:todo_frontend/features/auth/1_domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoggedInUserUC userUC;

  LoginCubit({required this.userUC}) : super(LoginState.initialState());

  void loggedInUser(UserEntity user) async {
    emit(state.copyWith(status: BlocStatus.loading));

    final failureOrSuccess = await userUC.call(
      UserEntity(email: user.email, password: user.password!),
    );

    failureOrSuccess.fold(
      (failure) => emit(state.copyWith(status: BlocStatus.error)),
      (id) {
        emit(state.copyWith(status: BlocStatus.success));
      },
    );
  }

  void isLoggedIn() {
    emit(state.copyWith(status: BlocStatus.success));
  }
}
