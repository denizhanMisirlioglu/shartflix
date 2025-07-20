import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/data_sources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/use_cases/get_popular_movies.dart';
import 'presentation/blocs/popular_movies_bloc/popular_movies_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => PopularMoviesBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetPopularMovies(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(remoteDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: sl()));

  // External (http client gibi)
  sl.registerLazySingleton(() => http.Client());
}
