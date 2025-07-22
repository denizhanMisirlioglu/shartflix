import 'dart:io';

abstract class UploadPhotoEvent {}

class UploadPhotoRequested extends UploadPhotoEvent {
  final File file;
  final String token;

  UploadPhotoRequested({required this.file, required this.token});
}
