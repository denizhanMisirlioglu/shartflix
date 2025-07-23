import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../entities/movie_page_result.dart';
import '../repositories/movie_repository.dart';

class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<Either<Failure, MoviePageResult>> call({
    int page = 1,
    required String token,
  }) {
    return repository.getMovies(page: page, token: token);
  }
}
