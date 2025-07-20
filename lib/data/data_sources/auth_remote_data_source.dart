import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shartflix/data/models/login_model.dart';
import 'package:shartflix/core/error/exception.dart';


abstract class AuthRemoteDataSource {
  Future<LoginModel> login(String email, String password);
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('https://caseapi.servicelabs.tech/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(); 
    }
  }
}
