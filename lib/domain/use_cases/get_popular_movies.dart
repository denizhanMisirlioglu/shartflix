import 'package:dartz/dartz.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';
import '../../../core/error/failure.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call() async {
    return await repository.getPopularMovies();
  }
}
