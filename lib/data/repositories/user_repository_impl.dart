import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data_sources/user_remote_data_source.dart';
import '../models/user_profile_model.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl(this.client);

  @override
  Future<UserProfileModel> getUserProfile(String token) async {
    final response = await client.get(
      Uri.parse('https://caseapi.servicelabs.tech/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return UserProfileModel.fromJson(decoded);
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }
}
