import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../../../domain/use_cases/upload_photo.dart';
import 'upload_photo_event.dart';
import 'upload_photo_state.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  final UploadPhoto uploadPhotoUseCase;

  UploadPhotoBloc(this.uploadPhotoUseCase) : super(UploadPhotoInitial()) {
    on<UploadPhotoRequested>(_onUploadPhotoRequested);
  }

  Future<void> _onUploadPhotoRequested(
      UploadPhotoRequested event,
      Emitter<UploadPhotoState> emit,
      ) async {
    emit(UploadPhotoLoading());
    try {
      final response = await uploadPhotoUseCase.execute(event.file, event.token);
      emit(UploadPhotoSuccess(response.photoUrl));
    } catch (e) {
      emit(UploadPhotoFailure(e.toString()));
    }
  }
}
