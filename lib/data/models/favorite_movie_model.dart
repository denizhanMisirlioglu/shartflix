import '../../../domain/entities/favorite_movie_entity.dart';

class FavoriteMovieModel extends FavoriteMovieEntity {
  final String description;

  const FavoriteMovieModel({
    required String id,
    required String title,
    required String posterUrl,
    required this.description,
  }) : super(
    id: id,
    title: title,
    posterUrl: posterUrl,
  );

  factory FavoriteMovieModel.fromJson(Map<String, dynamic> json) {
    final title = json['Title']?.toString();
    final posterUrl = json['Poster']?.toString();

    print(' Parsed title: $title');
    print(' Parsed posterUrl: $posterUrl');

    return FavoriteMovieModel(
      id: json['id']?.toString() ?? '',
      title: title ?? '',
      posterUrl: posterUrl ?? '',
      description: json['Plot']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'Title': title,
    'Poster': posterUrl,
    'Plot': description,
  };

  factory FavoriteMovieModel.fromEntity(FavoriteMovieEntity entity) {
    return FavoriteMovieModel(
      id: entity.id,
      title: entity.title,
      posterUrl: entity.posterUrl,
      description: '',
    );
  }


  FavoriteMovieEntity toEntity() {
    return FavoriteMovieEntity(
      id: id,
      title: title,
      posterUrl: posterUrl,
    );
  }
}
