import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_user_profile.dart';
import 'user_profile_event.dart';
import 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetUserProfile getUserProfile;

  UserProfileBloc(this.getUserProfile) : super(UserProfileInitial()) {
    on<FetchUserProfile>(_onFetchUserProfile);
  }

  Future<void> _onFetchUserProfile(
      FetchUserProfile event,
      Emitter<UserProfileState> emit,
      ) async {
    emit(UserProfileLoading());
    try {
      final profile = await getUserProfile(event.token);
      emit(UserProfileLoaded(profile));
    } catch (e) {
      emit(UserProfileError(e.toString()));
    }
  }
}
