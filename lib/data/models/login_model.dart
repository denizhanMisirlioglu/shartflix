import 'package:json_annotation/json_annotation.dart';
import 'package:shartflix/domain/entities/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String token;
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  const LoginModel({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
    );
  }


  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  LoginEntity toEntity() => LoginEntity(token: token);
}
