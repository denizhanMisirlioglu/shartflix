class UserProfileEntity {
  final String id;
  final String name;
  final String photoUrl;
  final String? email; // opsiyonel olarak ekliyoruz

  const UserProfileEntity({
    required this.id,
    required this.name,
    required this.photoUrl,
    this.email,
  });
}
