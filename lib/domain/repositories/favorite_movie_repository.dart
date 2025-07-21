import '../entities/favorite_movie_entity.dart';

abstract class FavoriteMovieRepository {
  Future<void> toggleFavorite(String token, String movieId);
  Future<List<FavoriteMovieEntity>> getFavoriteMovies(String token);
}
