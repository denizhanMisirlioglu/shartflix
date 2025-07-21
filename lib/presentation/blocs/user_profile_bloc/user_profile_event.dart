import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends UserProfileEvent {
  final String token;

  const FetchUserProfile(this.token);

  @override
  List<Object> get props => [token];
}
