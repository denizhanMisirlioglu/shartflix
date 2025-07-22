abstract class UploadPhotoState {}

class UploadPhotoInitial extends UploadPhotoState {}

class UploadPhotoLoading extends UploadPhotoState {}

class UploadPhotoSuccess extends UploadPhotoState {
  final String photoUrl;

  UploadPhotoSuccess(this.photoUrl);
}

class UploadPhotoFailure extends UploadPhotoState {
  final String message;

  UploadPhotoFailure(this.message);
}
