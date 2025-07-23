import 'movie_entity.dart';

class MoviePageResult {
  final List<MovieEntity> movies;
  final int currentPage;
  final int totalPages;

  const MoviePageResult({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
  });
}
