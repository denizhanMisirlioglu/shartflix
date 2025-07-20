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
      Uri.parse('https://caseapi.servicelabs.tech/movie/list'),
      headers: {
        'Content-Type': 'application/json',
        //'Authorization': 'Bearer $token', // token
      },
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
