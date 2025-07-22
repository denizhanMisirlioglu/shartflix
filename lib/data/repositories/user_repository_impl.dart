import 'dart:io';

import 'package:shartflix/domain/entities/user_profile_entity.dart';
import 'package:shartflix/domain/repositories/user_repository.dart';
import 'package:shartflix/data/data_sources/user_remote_data_source.dart';

import '../../domain/entities/upload_photo_response.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserProfileEntity> getUserProfile(String token) async {
    final model = await remoteDataSource.getUserProfile(token);
    return model.toEntity();
  }

  // 🆕 Yeni metot: fotoğraf yükleme
  @override
  Future<UploadPhotoResponse> uploadPhoto(File file, String token) async {
    final model = await remoteDataSource.uploadPhoto(file, token);
    return UploadPhotoResponse(photoUrl: model.photoUrl);
  }


}
