import '../entities/movie_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies();
}
