import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/favorite_movie_model.dart';

abstract class FavoriteMovieRemoteDataSource {
  Future<void> toggleFavorite(String token, String movieId);
  Future<List<FavoriteMovieModel>> getFavoriteMovies(String token);
}

class FavoriteMovieRemoteDataSourceImpl implements FavoriteMovieRemoteDataSource {
  final http.Client client;

  FavoriteMovieRemoteDataSourceImpl({required this.client});

  @override
  Future<void> toggleFavorite(String token, String movieId) async {
    final url = Uri.parse('https://caseapi.servicelabs.tech/movie/favorite/$movieId');

    final response = await client.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Favori işlemi başarısız: ${response.body}');
    }
  }

  @override
  Future<List<FavoriteMovieModel>> getFavoriteMovies(String token) async {
    final url = Uri.parse('https://caseapi.servicelabs.tech/movie/favorites');

    final response = await client.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List<dynamic> movies = decoded['movies'];
      return movies.map((json) => FavoriteMovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Favori filmler alınamadı: ${response.body}');
    }
  }
}
