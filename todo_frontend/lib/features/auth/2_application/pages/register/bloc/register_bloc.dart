import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_frontend/core/extension/bloc_api_status.dart';
import 'package:todo_frontend/features/auth/1_domain/entities/user_entity.dart';
import 'package:todo_frontend/features/auth/1_domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUC userUC;
  RegisterBloc({required this.userUC}) : super(RegisterState.initialState()) {
    on<UserRegisterSubmitEvent>(_registerUser);
  }

  Future<void> _registerUser(
    UserRegisterSubmitEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final failureOrSuccess = await userUC.call(
      UserEntity(
        username: event.user.username!,
        email: event.user.email,
        fullname: event.user.fullname!,
        password: event.user.password!,
      ),
    );

    failureOrSuccess.fold(
      (failure) => emit(state.copyWith(status: BlocStatus.error)),
      (success) => emit(state.copyWith(status: BlocStatus.success)),
    );
  }
}
