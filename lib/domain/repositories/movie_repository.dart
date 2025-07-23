import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../entities/movie_page_result.dart';

abstract class MovieRepository {
  Future<Either<Failure, MoviePageResult>> getMovies({
    int page = 1,
    required String token,
  });
}
