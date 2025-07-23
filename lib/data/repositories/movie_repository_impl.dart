import 'package:dartz/dartz.dart';
import '../../domain/entities/movie_page_result.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../../core/error/failure.dart';
import '../data_sources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MoviePageResult>> getMovies({
    int page = 1,
    required String token,
  }) async {
    try {
      final result = await remoteDataSource.getMovies(page: page, token: token);
      return Right(result);
    } catch (e, stackTrace) {
      print('❌ Repository getMovies() error: $e');
      print('📍 Stack trace: $stackTrace');
      return Left(ServerFailure());
    }
  }
}
