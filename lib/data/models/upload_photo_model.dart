import 'package:shartflix/domain/entities/upload_photo_response.dart';

class UploadPhotoModel extends UploadPhotoResponse {
  UploadPhotoModel({required String photoUrl}) : super(photoUrl: photoUrl);

  factory UploadPhotoModel.fromJson(Map<String, dynamic> json) {
    return UploadPhotoModel(photoUrl: json['photoUrl'] ?? '');
  }
}
