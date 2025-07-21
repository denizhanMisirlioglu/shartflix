import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_profile_entity.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  UserProfileEntity toEntity() => UserProfileEntity(
    id: id,
    name: name,
    photoUrl: photoUrl,
    email: email, // opsiyonel alanı Entity’ye geçiriyoruz
  );
}
