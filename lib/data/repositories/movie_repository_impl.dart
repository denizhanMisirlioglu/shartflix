import 'package:dartz/dartz.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../../core/error/failure.dart';
import '../data_sources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MovieEntity>>> getMovies({
    int page = 1,
    required String token,
  }) async {
    try {
      final movieModels = await remoteDataSource.getMovies(page: page, token: token);
      final movieEntities = movieModels.map((m) => m.toEntity()).toList();
      return Right(movieEntities);
    } catch (e, stackTrace) {
      print('❌ Repository getMovies() error: $e');
      print('📍 Stack trace: $stackTrace');
      return Left(ServerFailure());
    }
  }
}
