import '../entities/favorite_movie_entity.dart';
import '../repositories/favorite_movie_repository.dart';

class GetFavoriteMoviesUseCase {
  final FavoriteMovieRepository repository;

  GetFavoriteMoviesUseCase(this.repository);

  Future<List<FavoriteMovieEntity>> call(String token) {
    return repository.getFavoriteMovies(token);
  }
}
