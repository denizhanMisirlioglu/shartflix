import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/presentation/blocs/login_bloc/login_state.dart';
import 'package:shartflix/core/utils/token_storage.dart';
import '../../../domain/use_cases/login_user.dart';
import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final TokenStorage tokenStorage;

  LoginBloc({required this.loginUser, required this.tokenStorage})
      : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginPressed);
  }

  Future<void> _onLoginPressed(
      LoginButtonPressed event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    debugPrint(" Giriş isteği gönderildi: ${event.email}");

    final result = await loginUser(LoginRequest(
      email: event.email,
      password: event.password,
    ));

    await result.fold(
          (failure) async {
        debugPrint(" Giriş başarısız: $failure");
        emit(LoginFailure("E-posta veya şifre hatalı."));
      },
          (entity) async {
        debugPrint(" Giriş başarılı, token: ${entity.token}");
        await tokenStorage.saveToken(entity.token);
        emit(LoginSuccess(entity.token));
      },
    );
  }
}
