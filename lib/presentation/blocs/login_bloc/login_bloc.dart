import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/presentation/blocs/login_bloc/login_state.dart';

import '../../../domain/use_cases/login_user.dart';
import 'login_evet.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;

  LoginBloc({required this.loginUser}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginPressed);
  }

  Future<void> _onLoginPressed(
      LoginButtonPressed event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());

    final result = await loginUser(LoginRequest(
      email: event.email,
      password: event.password,
    ));

    result.fold(
          (failure) => emit(LoginFailure("Giriş başarısız oldu")),
          (entity) => emit(LoginSuccess()),
    );
  }
}
