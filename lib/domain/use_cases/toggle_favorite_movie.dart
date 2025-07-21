import '../repositories/favorite_movie_repository.dart';

class ToggleFavoriteMovieUseCase {
  final FavoriteMovieRepository repository;

  ToggleFavoriteMovieUseCase(this.repository);

  Future<void> call(String token, String movieId) {
    return repository.toggleFavorite(token, movieId);
  }
}
