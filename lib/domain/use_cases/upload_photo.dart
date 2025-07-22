import 'dart:io';
import '../entities/upload_photo_response.dart';
import '../repositories/user_repository.dart';

class UploadPhoto {
  final UserRepository repository;

  UploadPhoto(this.repository);

  Future<UploadPhotoResponse> execute(File file, String token) {
    return repository.uploadPhoto(file, token);
  }
}
