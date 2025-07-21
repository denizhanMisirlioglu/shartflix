import '../models/user_profile_model.dart';

abstract class UserRemoteDataSource {
  Future<UserProfileModel> getUserProfile(String token);
}
