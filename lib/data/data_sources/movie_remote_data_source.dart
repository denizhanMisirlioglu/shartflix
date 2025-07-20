// 🔧 movie_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(
      Uri.parse('https://caseapi.servicelabs.tech/api/v1/movies/popular'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List results = decoded['results'];
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}
