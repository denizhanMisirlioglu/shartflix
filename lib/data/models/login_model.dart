import 'package:json_annotation/json_annotation.dart';
import 'package:shartflix/domain/entities/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String token;

  const LoginModel({required this.token});

  /// JSON'dan LoginModel'e
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  /// LoginModel'den JSON'a
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  /// Entity'ye dönüştür
  LoginEntity toEntity() => LoginEntity(token: token);
}
