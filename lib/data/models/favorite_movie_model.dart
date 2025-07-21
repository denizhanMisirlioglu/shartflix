import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/favorite_movie_entity.dart';

part 'favorite_movie_model.g.dart';

@JsonSerializable()
class FavoriteMovieModel {
  final String id;
  final String title;
  final String description;
  final String posterUrl;

  const FavoriteMovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
  });

  factory FavoriteMovieModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteMovieModelToJson(this);

  FavoriteMovieEntity toEntity() => FavoriteMovieEntity(
    id: id,
    title: title,
    description: description,
    posterUrl: posterUrl,
  );

  factory FavoriteMovieModel.fromEntity(FavoriteMovieEntity entity) =>
      FavoriteMovieModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        posterUrl: entity.posterUrl,
      );
}
