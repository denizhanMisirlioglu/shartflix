import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMovies({int page = 1, required String token});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getMovies({int page = 1, required String token}) async {
    final response = await client.get(
      Uri.parse('https://caseapi.servicelabs.tech/movie/list?page=$page'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List movies = decoded['movies'];
      return movies.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movie list');
    }
  }
}
