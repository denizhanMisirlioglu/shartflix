import '../../domain/entities/favorite_movie_entity.dart';
import '../../domain/repositories/favorite_movie_repository.dart';
import '../data_sources/favorite_movie_remote_data_source.dart';

class FavoriteMovieRepositoryImpl implements FavoriteMovieRepository {
  final FavoriteMovieRemoteDataSource remoteDataSource;

  FavoriteMovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> toggleFavorite(String token, String movieId) async {
    try {
      await remoteDataSource.toggleFavorite(token, movieId);
    } catch (e) {
      throw Exception('Favori işlemi başarısız: $e');
    }
  }

  @override
  Future<List<FavoriteMovieEntity>> getFavoriteMovies(String token) async {
    try {
      final models = await remoteDataSource.getFavoriteMovies(token);
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      throw Exception('Favori filmler alınamadı: $e');
    }
  }
}
