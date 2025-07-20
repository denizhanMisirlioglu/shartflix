import 'package:dartz/dartz.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';
import '../../../core/error/failure.dart';

class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call({
    int page = 1,
    required String token,
  }) {
    return repository.getMovies(page: page, token: token);
  }
}
