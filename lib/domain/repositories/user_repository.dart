import 'dart:io';

import '../entities/upload_photo_response.dart';
import '../entities/user_profile_entity.dart';

abstract class UserRepository {
  Future<UserProfileEntity> getUserProfile(String token);

  // 🆕 Yeni özellik: profil fotoğrafı yükleme
  Future<UploadPhotoResponse> uploadPhoto(File file, String token);
}
