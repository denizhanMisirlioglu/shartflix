import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../models/upload_photo_model.dart';
import '../models/user_profile_model.dart';

abstract class UserRemoteDataSource {
  Future<UserProfileModel> getUserProfile(String token);
  Future<UploadPhotoModel> uploadPhoto(File file, String token);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserProfileModel> getUserProfile(String token) async {
    final response = await client.get(
      Uri.parse('https://caseapi.servicelabs.tech/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return UserProfileModel.fromJson(jsonMap['data']);
    } else {
      throw Exception('error.getProfileFailed');
    }
  }

  @override
  Future<UploadPhotoModel> uploadPhoto(File file, String token) async {
    final uri = Uri.parse('https://caseapi.servicelabs.tech/user/upload_photo');
    print(' DataSource: Fotoğraf yükleme isteği hazırlanıyor → ${file.path}');

    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';

    final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
    final mediaType = MediaType.parse(mimeType);

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
      contentType: mediaType,
    ));

    print(' DataSource: İstek gönderiliyor...');
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print(' Upload yanıt status: ${response.statusCode}');
    print(' Upload response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return UploadPhotoModel.fromJson(jsonMap);
    } else if (response.statusCode == 400) {
      throw Exception("error.invalidFileFormat");
    } else if (response.statusCode == 401) {
      throw Exception("error.unauthorized");
    } else {
      throw Exception("error.uploadPhotoFailed");
    }
  }
}
