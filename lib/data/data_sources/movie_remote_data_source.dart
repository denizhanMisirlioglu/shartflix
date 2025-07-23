import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/entities/movie_page_result.dart';
import '../../../domain/entities/movie_entity.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<MoviePageResult> getMovies({int page = 1, required String token});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<MoviePageResult> getMovies({int page = 1, required String token}) async {
    final url = 'https://caseapi.servicelabs.tech/movie/list?page=$page';
    print('🌐 [GET] Request to: $url');

    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('📡 Movie list response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final data = decoded['data'];

      final moviesJson = data['movies'] ?? [];
      final currentPage = data['currentPage'] ?? 1;
      final totalPages = data['totalPages'] ?? 1;

      print('✅ API response parsed');
      print('📄 currentPage: $currentPage | totalPages: $totalPages | movies.length: ${moviesJson.length}');

      final movies = (moviesJson as List)
          .map((json) => MovieModel.fromJson(json).toEntity())
          .toList();

      // Film başlığı ve poster logları
      for (var movie in movies) {
        print('🎬 [Movie] ${movie.title} → posterUrl: ${movie.posterUrl}');
      }

      return MoviePageResult(
        movies: movies,
        currentPage: currentPage,
        totalPages: totalPages,
      );
    } else {
      print('❌ Failed to load movie list, status: ${response.statusCode}');
      throw Exception('Failed to load movie list, status: ${response.statusCode}');
    }
  }
}
