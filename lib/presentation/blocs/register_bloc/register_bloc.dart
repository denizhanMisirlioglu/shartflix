import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/presentation/blocs/register_bloc/register_event.dart';
import 'package:shartflix/presentation/blocs/register_bloc/register_state.dart';

import '../../../domain/use_cases/register_user.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUser;

  RegisterBloc({required this.registerUser}) : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterPressed);
  }

  Future<void> _onRegisterPressed(
      RegisterButtonPressed event,
      Emitter<RegisterState> emit,
      ) async {
    emit(RegisterLoading());

    final result = await registerUser(RegisterRequest(
      email: event.email,
      password: event.password,
      fullName: event.fullName,
    ));

    result.fold(
          (failure) => emit(RegisterFailure("Kayıt başarısız oldu")),
          (_) => emit(RegisterSuccess()),
    );
  }
}
