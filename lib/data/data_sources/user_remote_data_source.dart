import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_profile_model.dart';

abstract class UserRemoteDataSource {
  Future<UserProfileModel> getUserProfile(String token);
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
      throw Exception('Kullanıcı profili alınamadı: ${response.statusCode}');
    }
  }
}
