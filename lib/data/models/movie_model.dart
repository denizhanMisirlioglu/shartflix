import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/movie_entity.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final String id;

  @JsonKey(name: 'Title')
  final String title;

  @JsonKey(name: 'Released')
  final String releaseDate;

  @JsonKey(name: 'Poster')
  final String posterUrl;

  MovieModel({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterUrl,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      releaseDate: releaseDate,
      posterUrl: posterUrl,
    );
  }
}

