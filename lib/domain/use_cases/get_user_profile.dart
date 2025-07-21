import 'package:shartflix/domain/entities/user_profile_entity.dart';
import 'package:shartflix/domain/repositories/user_repository.dart';

class GetUserProfile {
  final UserRepository repository;

  GetUserProfile(this.repository);

  Future<UserProfileEntity> execute(String token) {
    return repository.getUserProfile(token);
  }
}
